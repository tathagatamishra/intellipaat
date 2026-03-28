# SQL Session Notes

| Day    | Main Topics Covered                                                                                |
|--------|----------------------------------------------------------------------------------------------------|
| Day 1  | SSMS installation, setup and introduction                                                          |
| Day 2  | SQL basics, DDL, DQL, DML, `CREATE TABLE`, `SELECT`, `ALTER`, `DROP`                               |
| Day 3  | DCL, numeric/string/date data types, arithmetic and logical operators, `LIKE`, `BETWEEN`, `IN`     |
| Day 4  | Constraints, joins, foreign keys, `INNER/LEFT/RIGHT/FULL/CROSS JOIN`                               |
| Day 5  | Self join, aliases, string functions, date functions, math functions                               |
| Day 6  | Aggregate functions, window functions, `HAVING`, scalar UDFs                                       |
| Day 7  | I forgot to save the sql file so I lost all the note I taken in that session                       |
| Day 8  | Views, `PIVOT`, `UNPIVOT`, subqueries, temp tables, CTE                                            |
| Day 9  | Hands-on session, `VARCHAR` vs `CHAR`, `NVARCHAR`, `LEFT/RIGHT`, `NOT LIKE`, joins                 |
| Day 10 | Set operators, triggers, indexes, `ROLLUP`, `CUBE`, `CAST`, `CONVERT`, `IIF`, `ISNULL`, `COALESCE` |

---

</br>

## 1) SQL Command Categories

| Category | Full Form                    | Purpose                                   | Main Commands / Keywords                             |
|----------|------------------------------|-------------------------------------------|------------------------------------------------------|
| DDL      | Data Definition Language     | Create or modify database objects         | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME`      |
| DQL      | Data Query Language          | Read data from tables                     | `SELECT`                                             |
| DML      | Data Manipulation Language   | Insert, update, and delete row-level data | `INSERT`, `UPDATE`, `DELETE`, `MERGE`                |
| DCL      | Data Control Language        | Manage permissions                        | `GRANT`, `REVOKE`                                    |
| TCL      | Transaction Control Language | Control transactions                      | `COMMIT`, `ROLLBACK`, `SAVEPOINT`, `SET TRANSACTION` |

---

</br>

## 2) TCL - Transaction Control Language

TCL commands manage transactions, allowing you to save or undo a group of DML changes as a single unit.

| Command           | Purpose                                        | Notes                                              |
|-------------------|------------------------------------------------|----------------------------------------------------|
| `COMMIT`          | Permanently saves all changes in a transaction | Changes become visible to other users after commit |
| `ROLLBACK`        | Undoes all changes made since the last commit  | Reverts to the last committed state                |
| `SAVEPOINT`       | Sets a named checkpoint within a transaction   | Allows partial rollback to that point              |
| `SET TRANSACTION` | Configures transaction properties              | e.g., isolation level                              |

### Example

```sql
BEGIN TRANSACTION;

UPDATE Employees SET Salary = Salary + 5000 WHERE DepartmentID = 2;

-- If something goes wrong:
ROLLBACK;

-- If everything looks good:
COMMIT;
```

---

</br>

## 3) Core SQL Statements

| Statement                      | Syntax Pattern                                      | What it does               | Notes from the sessions                                               |
|--------------------------------|-----------------------------------------------------|----------------------------|-----------------------------------------------------------------------|
| `CREATE DATABASE`              | `CREATE DATABASE database_name`                     | Creates a database         | Use square brackets for spaces: `CREATE DATABASE [My First Database]` |
| `CREATE TABLE`                 | `CREATE TABLE table_name (...)`                     | Creates a table            | Column definitions are placed inside parentheses                      |
| `SELECT`                       | `SELECT column_list FROM table_name`                | Retrieves data             | `*` means all columns                                                 |
| `INSERT INTO`                  | `INSERT INTO table_name (cols) VALUES (...)`        | Adds new rows              | Can insert multiple rows at once                                      |
| `UPDATE`                       | `UPDATE table_name SET col = value WHERE condition` | Modifies existing rows     | Without `WHERE`, all rows are affected                                |
| `DELETE FROM`                  | `DELETE FROM table_name WHERE condition`            | Deletes rows               | Without `WHERE`, all rows are deleted                                 |
| `ALTER TABLE ... ADD`          | `ALTER TABLE table_name ADD col datatype`           | Adds new columns           | New column is appended at the end                                     |
| `ALTER TABLE ... ALTER COLUMN` | `ALTER TABLE table_name ALTER COLUMN col datatype`  | Changes column type        | Example: `INT` to `FLOAT`                                             |
| `ALTER TABLE ... DROP COLUMN`  | `ALTER TABLE table_name DROP COLUMN col`            | Removes a column           | Used to delete a column from table structure                          |
| `DROP TABLE`                   | `DROP TABLE table_name`                             | Deletes a table completely | Table becomes unavailable after drop                                  |
| `GRANT`                        | `GRANT permission ON object TO user`                | Gives permission           | Example: `GRANT SELECT ON Employees TO User1`                         |
| `REVOKE`                       | `REVOKE permission ON object FROM user`             | Removes permission         | Example: `REVOKE SELECT ON Employees FROM User1`                      |

---

</br>

## 4) SQL Data Types

| Type Group | Data Type       | Meaning / Use               | Notes                                 |
|------------|-----------------|-----------------------------|---------------------------------------|
| Numeric    | `TINYINT`       | Small integer range         | `0` to `255`                          |
| Numeric    | `SMALLINT`      | Small integer range         | `-32,768` to `32,767`                 |
| Numeric    | `INT`           | Standard integer            | `-2,147,483,648` to `2,147,483,647`   |
| Numeric    | `BIGINT`        | Large integer range         | 8 bytes                               |
| Numeric    | `DECIMAL(p, s)` | Exact numeric values        | `p = precision`, `s = scale`          |
| String     | `CHAR(n)`       | Fixed-length text           | Pads with spaces                      |
| String     | `VARCHAR(n)`    | Variable-length text        | Stores only actual text               |
| String     | `NVARCHAR(n)`   | Unicode / multilingual text | Use `N'...'` for multilingual strings |
| String     | `VARCHAR(MAX)`  | Very large variable text    | Max storage supported                 |
| String     | `NVARCHAR(MAX)` | Very large Unicode text     | Max storage supported                 |
| Date/Time  | `DATE`          | Date only                   | `YYYY-MM-DD`                          |
| Date/Time  | `TIME`          | Time only                   | `HH:MM:SS`                            |
| Date/Time  | `DATETIME`      | Date + time                 | `YYYY-MM-DD HH:MM:SS`                 |
| Date/Time  | `DATETIME2`     | Higher precision date/time  | Supports nanoseconds                  |

---

</br>

## 5) Constraints

| Constraint    | Purpose                                            | Example / Behavior                                                            |
|---------------|----------------------------------------------------|-------------------------------------------------------------------------------|
| `NOT NULL`    | Prevents NULL values                               | Cannot insert a row without that column value                                 |
| `UNIQUE`      | Ensures all values are different                   | Duplicate values are not allowed                                              |
| `CHECK`       | Enforces a rule                                    | Example: `Age INT CHECK (Age >= 18)`                                          |
| `DEFAULT`     | Inserts a fallback value when no value is provided | Only works when the column is omitted, not when `NULL` is explicitly inserted |
| `PRIMARY KEY` | Uniquely identifies each row                       | Combines `UNIQUE + NOT NULL`                                                  |
| `FOREIGN KEY` | Links one table to another                         | Requires referenced column to be a primary key or unique key                  |

---

</br>

## 6) Operators and Predicates

| Type             | Operators / Keywords                  | Purpose                 | Example                                 |
|------------------|---------------------------------------|-------------------------|-----------------------------------------|
| Arithmetic       | `+`, `-`, `*`, `/`, `%`               | Mathematical operations | `SELECT 10 + 5`                         |
| Comparison       | `=`, `<>`, `!=`, `>`, `<`, `>=`, `<=` | Compare values          | `WHERE Salary >= 50000`                 |
| Logical          | `AND`, `OR`, `NOT`                    | Combine conditions      | `WHERE Gender = 'M' AND Salary > 55000` |
| Set / Membership | `IN`, `NOT IN`                        | Match against a list    | `WHERE UserID IN (2, 4)`                |
| Range            | `BETWEEN`                             | Match values in a range | `WHERE Salary BETWEEN 52000 AND 60000`  |
| Pattern          | `LIKE`                                | Pattern-based matching  | `LIKE 'J%'`, `LIKE '%on'`, `LIKE '_a%'` |
| NULL handling    | `IS NULL`, `IS NOT NULL`              | Check NULL values       | `WHERE DepartmentID IS NULL`            |

---

</br>

## 7) JOINs and Relationships

| Join Type              | Result                                                    | Notes                                     |
|------------------------|-----------------------------------------------------------|-------------------------------------------|
| `INNER JOIN`           | Only matching rows from both tables                       | Used when both sides must match           |
| `LEFT JOIN`            | All rows from left table + matching rows from right table | Non-matching right side becomes `NULL`    |
| `RIGHT JOIN`           | All rows from right table + matching rows from left table | Non-matching left side becomes `NULL`     |
| `FULL OUTER JOIN`      | All rows from both tables                                 | Matching and non-matching rows included   |
| `CROSS JOIN`           | All possible combinations                                 | Also called Cartesian Product             |
| Self Join              | Table joined with itself                                  | Used for parent-child style relationships |
| Foreign Key Join Logic | Connects dependent table to parent table                  | Commonly paired with `PRIMARY KEY`        |

### Common join syntax

```sql
SELECT columns
FROM TableA
INNER JOIN TableB
ON TableA.key = TableB.key;
```

---

</br>

## 8) Aggregate and Grouping Features

| Feature    | Purpose                              | Example                               |
|------------|--------------------------------------|---------------------------------------|
| `SUM()`    | Adds values                          | `SUM(Salary)`                         |
| `MAX()`    | Highest value                        | `MAX(Salary)`                         |
| `MIN()`    | Lowest value                         | `MIN(Salary)`                         |
| `AVG()`    | Average value                        | `AVG(Salary)`                         |
| `COUNT()`  | Counts rows                          | `COUNT(*)`                            |
| `GROUP BY` | Groups rows for aggregation          | `GROUP BY DepartmentName`             |
| `HAVING`   | Filters grouped results              | `HAVING SUM(Salary) > 50000`          |
| `ROLLUP`   | Hierarchical subtotals + grand total | `GROUP BY ROLLUP(continent, country)` |
| `CUBE`     | All grouping combinations            | `GROUP BY CUBE(continent, country)`   |

---

</br>

## 9) Window Functions

| Function       | Purpose                      | Important Syntax Note     |
|----------------|------------------------------|---------------------------|
| `ROW_NUMBER()` | Sequential row numbering     | Requires `OVER(...)`      |
| `RANK()`       | Ranking with gaps after ties | Uses `OVER(ORDER BY ...)` |
| `DENSE_RANK()` | Ranking without gaps         | Uses `OVER(ORDER BY ...)` |
| `NTILE(n)`     | Splits rows into `n` groups  | Uses `OVER(ORDER BY ...)` |

### Core pattern

```sql
SELECT ROW_NUMBER() OVER (ORDER BY Salary ASC) AS RowID, *
FROM UserData;
```

---

</br>

## 10) String Functions

| Function      | Purpose                             | Example                      |
|---------------|-------------------------------------|------------------------------|
| `UPPER()`     | Converts text to uppercase          | `UPPER(Name)`                |
| `LOWER()`     | Converts text to lowercase          | `LOWER(Name)`                |
| `LTRIM()`     | Removes leading spaces              | `LTRIM(Name)`                |
| `RTRIM()`     | Removes trailing spaces             | `RTRIM(Name)`                |
| `TRIM()`      | Removes spaces from both sides      | `TRIM(Name)`                 |
| `REPLACE()`   | Replaces one substring with another | `REPLACE(Name, 'i', 'b')`    |
| `LEN()`       | Counts characters                   | `LEN('My Name')`             |
| `SUBSTRING()` | Extracts part of a string           | `SUBSTRING('Charlie', 2, 2)` |
| `REVERSE()`   | Reverses string order               | `REVERSE('Charlie')`         |
| `LEFT()`      | Returns leftmost characters         | `LEFT(last_name, 1)`         |
| `RIGHT()`     | Returns rightmost characters        | `RIGHT(last_name, 1)`        |

---

</br>

## 11) Date and Time Functions

| Function     | Purpose                                 | Example                            |
|--------------|-----------------------------------------|------------------------------------|
| `GETDATE()`  | Current date and time                   | `SELECT GETDATE()`                 |
| `DAY()`      | Day number from date                    | `DAY(GETDATE())`                   |
| `MONTH()`    | Month number from date                  | `MONTH(GETDATE())`                 |
| `YEAR()`     | Year from date                          | `YEAR(GETDATE())`                  |
| `DATEADD()`  | Adds time units to a date               | `DATEADD(dd, 10, '2026-03-07')`    |
| `DATEDIFF()` | Calculates difference between two dates | `DATEDIFF(dd, startdate, enddate)` |
| `DATENAME()` | Returns name of month/day               | `DATENAME(mm, GETDATE())`          |
| `DATEPART()` | Returns a part of the date              | `DATEPART(WEEK, GETDATE())`        |

---

</br>

## 12) Numeric / Mathematical Functions

| Function    | Purpose                  | Example            |
|-------------|--------------------------|--------------------|
| `POWER()`   | Raises number to a power | `POWER(2, 3)`      |
| `SQRT()`    | Square root              | `SQRT(10)`         |
| `ABS()`     | Absolute value           | `ABS(-10)`         |
| `FLOOR()`   | Rounds down              | `FLOOR(100.897)`   |
| `CEILING()` | Rounds up                | `CEILING(100.123)` |

---

</br>

## 13) Conditional / Utility Functions

| Function     | Purpose                           | Example                                                |
|--------------|-----------------------------------|--------------------------------------------------------|
| `CAST()`     | Converts data type                | `CAST(GETDATE() AS date)`                              |
| `CONVERT()`  | Converts data type / formats date | `CONVERT(VARCHAR(20), GETDATE(), 101)`                 |
| `IIF()`      | Inline if-else logic              | `IIF(Sex='M', 'Male', 'Female')`                       |
| `ISNULL()`   | Replaces NULL with a value        | `ISNULL(Salary, 0)`                                    |
| `COALESCE()` | Returns first non-NULL value      | `COALESCE(Address1, Address2, Address3, 'No Address')` |

---

</br>

## 14) User-Defined Functions (UDF)

| Type                  | Meaning                | Notes                                              |
|-----------------------|------------------------|----------------------------------------------------|
| Scalar Function       | Returns a single value | Called with schema name, e.g. `dbo.getNameById(1)` |
| Table-Valued Function | Returns a table result | Mentioned as a UDF type                            |

### Scalar function pattern

```sql
CREATE FUNCTION function_name (@parameter DATATYPE)
RETURNS DATATYPE
AS
BEGIN
    RETURN (
        SELECT ...
    );
END
```

---

</br>

## 15) Views, Subqueries, Temp Tables, Procedures

| Topic                         | Meaning                            | Notes                                   |
|-------------------------------|------------------------------------|-----------------------------------------|
| `VIEW`                        | Saved query                        | Reusable select logic                   |
| `SUBQUERY`                    | Query inside another query         | Useful for dynamic filtering            |
| Correlated Subquery           | Inner query depends on outer query | Often uses outer table alias            |
| Temporary Table               | Session-only table                 | Starts with `#`                         |
| Common Table Expression (CTE) | Named temporary result set         | Starts with `;WITH`                     |
| Stored Procedure              | Saved executable SQL block         | Mentioned in the notes with temp tables |

### Example temp table syntax

```sql
CREATE TABLE #StudentInfo (
    Id INT,
    Name VARCHAR(50)
);
```

---

</br>

## 16) Set Operators

| Operator    | Purpose                                     | Behavior           |
|-------------|---------------------------------------------|--------------------|
| `UNION`     | Combines result sets                        | Removes duplicates |
| `UNION ALL` | Combines result sets                        | Keeps duplicates   |
| `EXCEPT`    | Returns rows from first query not in second | Set difference     |
| `INTERSECT` | Returns common rows                         | Set intersection   |

### Rule for set operators

| Rule            | Requirement                                                   |
|-----------------|---------------------------------------------------------------|
| Column count    | Both SELECT statements must return the same number of columns |
| Data type match | Corresponding columns must have compatible data types         |

---

</br>

## 17) Triggers and Indexes

| Topic                | Purpose                            | Notes                                                   |
|----------------------|------------------------------------|---------------------------------------------------------|
| `DML TRIGGER`        | Runs after data changes            | `AFTER INSERT`, `AFTER UPDATE`, `AFTER DELETE`          |
| `DDL TRIGGER`        | Runs on schema events              | `FOR CREATE_TABLE`, `FOR ALTER_TABLE`, `FOR DROP_TABLE` |
| `CLUSTERED INDEX`    | Sorts and stores table data by key | Only one per table                                      |
| `NONCLUSTERED INDEX` | Separate index structure           | Faster lookups on selected columns                      |

### Common syntax

```sql
CREATE TRIGGER trigger_name
ON Table_name
AFTER INSERT
AS
BEGIN
    -- logic
END
```

```sql
CREATE NONCLUSTERED INDEX IndexName
ON TableName(ColumnName);

-- Drop an index
DROP INDEX IndexName ON TableName;
```

### `FOR` vs `AFTER` in DDL Triggers

In DDL triggers, `FOR` and `AFTER` behave identically. There is no functional difference. `FOR` is the conventional choice for DDL triggers purely for clarity and consistency.

```sql
-- These two are equivalent:
CREATE TRIGGER TriggerCreateMsg ON DATABASE FOR CREATE_TABLE AS BEGIN PRINT 'created' END;
CREATE TRIGGER TriggerCreateMsg ON DATABASE AFTER CREATE_TABLE AS BEGIN PRINT 'created' END;
```

### ![!](https://dummyimage.com/14/ffd230/white?text=!) &nbsp; `PRINT` vs `SELECT` inside Triggers

| Statement  | Recommended | Notes                                                                       |
|------------|-------------|-----------------------------------------------------------------------------|
| `PRINT`    | Yes         | Sends a message to the messages tab                                         |
| `SELECT`   | Not ideal   | Returns a result set, which can cause unexpected behaviour inside a trigger |

---

</br>

## 18) Operators for Data Reshaping and Special Techniques

| Topic     | Purpose                    | Notes                                 |
|-----------|----------------------------|---------------------------------------|
| `PIVOT`   | Converts rows into columns | Used for report-style summaries       |
| `UNPIVOT` | Converts columns into rows | Useful for normalization and analysis |

---

</br>

## 19) Quick SQL Examples from the Notes

| Goal                            | Example                                                                                                            |
|---------------------------------|--------------------------------------------------------------------------------------------------------------------|
| Show employee by ID             | `SELECT * FROM Employee WHERE EmployeeID = 1`                                                                      |
| Show users with multiple IDs    | `SELECT * FROM UserData WHERE UserID IN (2, 4)`                                                                    |
| Salary range                    | `SELECT * FROM UserData WHERE Salary BETWEEN 52000 AND 60000`                                                      |
| Join employees with departments | `SELECT ... FROM Employee INNER JOIN Department ON Employee.DepartmentID = Department.DepartmentID`                |
| Highest salary                  | `SELECT * FROM Employee WHERE Salary = (SELECT MAX(Salary) FROM Employee)`                                         |
| Add 5 years and 6 months        | `DATEADD(mm, 6, DATEADD(yy, 5, GETDATE()))`                                                                        |
| 3rd highest salary              | `SELECT * FROM (SELECT DENSE_RANK() OVER (ORDER BY Salary DESC) AS RankID, * FROM UserData) AS W WHERE RankID = 3` |
| Group salary by department      | `SELECT DepartmentName, SUM(Salary) FROM ... GROUP BY DepartmentName`                                              |

---

</br>

## 20) Important Syntax Reminders

| Topic               | Reminder                                                                        |
|---------------------|---------------------------------------------------------------------------------|
| String literals     | Use single quotes: `'John Doe'`                                                 |
| Unicode text        | Use `N'...'` with `NVARCHAR`                                                    |
| Column aliases      | Use `AS` for readability                                                        |
| `WHERE` vs `HAVING` | `WHERE` filters rows before grouping, `HAVING` filters grouped results          |
| `ROW_NUMBER()`      | Must include `OVER(...)`                                                        |
| `NULL` comparison   | Use `IS NULL`, not `= NULL`                                                     |
| `PRIMARY KEY`       | One table can have only one primary key constraint                              |
| `DEFAULT`           | Works only when column value is omitted, not when `NULL` is explicitly inserted |

---
