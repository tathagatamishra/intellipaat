const fs = require('fs');
const {
  Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
  HeadingLevel, BorderStyle, WidthType, ShadingType, AlignmentType
} = require('docx');

const CONTENT_WIDTH = 9360; // DXA for US Letter with 1" margins

// Parse inline backtick code from a string → array of TextRun
function parseRuns(text, size = 22, bold = false, color = undefined) {
  if (!text) return [new TextRun({ text: '', size, bold })];
  // Strip markdown images and HTML entities
  text = text
    .replace(/!\[.*?\]\(.*?\)/g, '')
    .replace(/&nbsp;/g, ' ')
    .trim();
  if (!text) return [new TextRun({ text: '', size, bold })];

  const parts = text.split(/(`[^`]+`)/);
  return parts
    .map(part => {
      if (part.startsWith('`') && part.endsWith('`')) {
        return new TextRun({
          text: part.slice(1, -1),
          font: 'Courier New',
          size: Math.max(size - 2, 16),
          bold,
          ...(color ? { color } : {})
        });
      }
      if (part) {
        return new TextRun({
          text: part,
          font: 'Arial',
          size,
          bold,
          ...(color ? { color } : {})
        });
      }
      return null;
    })
    .filter(Boolean);
}

function makePara(text, spacing = { after: 120 }) {
  return new Paragraph({ children: parseRuns(text), spacing });
}

function makeH1(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_1,
    children: parseRuns(text, 36, true),
  });
}

function makeH2(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_2,
    children: parseRuns(text, 28, true),
  });
}

function makeH3(text) {
  return new Paragraph({
    heading: HeadingLevel.HEADING_3,
    children: parseRuns(text, 22, true),
  });
}

function makeHR() {
  return new Paragraph({
    children: [],
    border: { bottom: { style: BorderStyle.SINGLE, size: 2, color: 'BBBBBB', space: 1 } },
    spacing: { before: 160, after: 160 }
  });
}

function makeCodeBlock(codeLines) {
  const elements = [
    new Paragraph({ children: [], spacing: { before: 60, after: 0 } })
  ];
  for (const line of codeLines) {
    elements.push(new Paragraph({
      children: [new TextRun({
        text: line === '' ? ' ' : line,
        font: 'Courier New',
        size: 18,
        color: '1F1F1F'
      })],
      shading: { fill: 'F4F4F4', type: ShadingType.CLEAR },
      spacing: { before: 0, after: 0 },
      indent: { left: 360, right: 360 }
    }));
  }
  elements.push(new Paragraph({ children: [], spacing: { before: 0, after: 120 } }));
  return elements;
}

function makeQuote(text) {
  return new Paragraph({
    children: parseRuns(text, 20),
    indent: { left: 720 },
    border: { left: { style: BorderStyle.SINGLE, size: 12, color: '4472C4', space: 6 } },
    shading: { fill: 'EEF4FB', type: ShadingType.CLEAR },
    spacing: { before: 100, after: 100 }
  });
}

function makeTable(rows) {
  if (!rows || rows.length === 0) return [];
  const numCols = Math.max(...rows.map(r => r.length));
  if (numCols === 0) return [];

  const baseColWidth = Math.floor(CONTENT_WIDTH / numCols);
  const columnWidths = Array(numCols).fill(baseColWidth);
  const diff = CONTENT_WIDTH - baseColWidth * numCols;
  columnWidths[numCols - 1] += diff;

  const border = { style: BorderStyle.SINGLE, size: 1, color: 'CCCCCC' };
  const borders = { top: border, bottom: border, left: border, right: border };

  const tableRows = rows.map((row, rowIdx) => {
    const isHeader = rowIdx === 0;
    const paddedRow = [...row];
    while (paddedRow.length < numCols) paddedRow.push('');

    const cells = paddedRow.map((cell, colIdx) => {
      return new TableCell({
        borders,
        width: { size: columnWidths[colIdx], type: WidthType.DXA },
        shading: isHeader
          ? { fill: 'D0E4F7', type: ShadingType.CLEAR }
          : { fill: 'FFFFFF', type: ShadingType.CLEAR },
        margins: { top: 80, bottom: 80, left: 120, right: 120 },
        verticalAlign: 'center',
        children: [new Paragraph({
          children: parseRuns(cell, 18, isHeader),
          spacing: { before: 0, after: 0 }
        })]
      });
    });

    return new TableRow({ children: cells });
  });

  return [
    new Table({
      width: { size: CONTENT_WIDTH, type: WidthType.DXA },
      columnWidths,
      rows: tableRows
    }),
    new Paragraph({ children: [], spacing: { after: 160 } })
  ];
}

// ── Parse markdown into blocks ──────────────────────────────────────────────
const content = fs.readFileSync('../SQL/README.md', 'utf8');
const lines = content.split('\n');
const blocks = [];
let i = 0;

while (i < lines.length) {
  const raw = lines[i];
  const trimmed = raw.trim();

  // Skip blanks and HTML breaks
  if (!trimmed || trimmed === '</br>') { i++; continue; }

  // H1 (but not ## or ###)
  if (/^# [^#]/.test(trimmed)) {
    blocks.push({ type: 'h1', text: trimmed.slice(2).trim() });
    i++; continue;
  }

  // H3 before H2 to avoid false match
  if (trimmed.startsWith('### ')) {
    blocks.push({ type: 'h3', text: trimmed.slice(4).trim() });
    i++; continue;
  }

  // H2
  if (trimmed.startsWith('## ')) {
    blocks.push({ type: 'h2', text: trimmed.slice(3).trim() });
    i++; continue;
  }

  // HR
  if (trimmed === '---') {
    blocks.push({ type: 'hr' });
    i++; continue;
  }

  // Code block
  if (trimmed.startsWith('```')) {
    const codeLines = [];
    i++;
    while (i < lines.length && !lines[i].trim().startsWith('```')) {
      codeLines.push(lines[i]);
      i++;
    }
    i++; // closing ```
    blocks.push({ type: 'code', lines: codeLines });
    continue;
  }

  // Table
  if (trimmed.startsWith('|')) {
    const tableLines = [];
    while (i < lines.length && lines[i].trim().startsWith('|')) {
      tableLines.push(lines[i]);
      i++;
    }
    // Filter out separator rows (e.g., |---|---|)
    const rows = tableLines
      .filter(l => !/^\|[\s\-|:]+\|$/.test(l.trim()))
      .map(l =>
        l.trim()
          .split('|')
          .slice(1, -1)
          .map(c => c.trim())
      );
    if (rows.length > 0) blocks.push({ type: 'table', rows });
    continue;
  }

  // Blockquote
  if (trimmed.startsWith('> ')) {
    blocks.push({ type: 'quote', text: trimmed.slice(2) });
    i++; continue;
  }

  // Regular paragraph
  blocks.push({ type: 'para', text: trimmed });
  i++;
}

// ── Convert blocks → docx children ─────────────────────────────────────────
const children = [];

for (const block of blocks) {
  switch (block.type) {
    case 'h1':  children.push(makeH1(block.text)); break;
    case 'h2':  children.push(makeH2(block.text)); break;
    case 'h3':  children.push(makeH3(block.text)); break;
    case 'hr':  children.push(makeHR()); break;
    case 'code': children.push(...makeCodeBlock(block.lines)); break;
    case 'table': children.push(...makeTable(block.rows)); break;
    case 'quote': children.push(makeQuote(block.text)); break;
    case 'para':  children.push(makePara(block.text)); break;
  }
}

// ── Build Document ───────────────────────────────────────────────────────────
const doc = new Document({
  styles: {
    default: {
      document: { run: { font: 'Arial', size: 22 } }
    },
    paragraphStyles: [
      {
        id: 'Heading1', name: 'Heading 1',
        basedOn: 'Normal', next: 'Normal', quickFormat: true,
        run: { size: 36, bold: true, font: 'Arial', color: '1F3864' },
        paragraph: { spacing: { before: 240, after: 200 }, outlineLevel: 0 }
      },
      {
        id: 'Heading2', name: 'Heading 2',
        basedOn: 'Normal', next: 'Normal', quickFormat: true,
        run: { size: 28, bold: true, font: 'Arial', color: '2E75B6' },
        paragraph: { spacing: { before: 280, after: 120 }, outlineLevel: 1 }
      },
      {
        id: 'Heading3', name: 'Heading 3',
        basedOn: 'Normal', next: 'Normal', quickFormat: true,
        run: { size: 22, bold: true, font: 'Arial', color: '2F5597' },
        paragraph: { spacing: { before: 200, after: 80 }, outlineLevel: 2 }
      },
    ]
  },
  sections: [{
    properties: {
      page: {
        size: { width: 12240, height: 15840 },
        margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 }
      }
    },
    children
  }]
});

Packer.toBuffer(doc).then(buf => {
  fs.writeFileSync('SQL_Session_Notes.docx', buf);
  console.log('Created SQL_Session_Notes.docx');
}).catch(err => {
  console.error('Error:', err);
  process.exit(1);
});