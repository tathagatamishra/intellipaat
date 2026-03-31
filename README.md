# Intellipaat

Personal notes, hands-on exercises, and resources from the Intellipaat Data Science & AI program.

---

</br>

## My Setup

- Python 3.13.12
- Mini Anaconda CLI
- VSCode
- Environment name --> `intellipaat` (conda)

## Core Packages

- ipykernel
- jupyterlab
- matplotlib
- notebook
- numpy
- pandas
- scikit-learn
- seaborn

## Steps

```bash
# Step 1: Clone
git clone https://github.com/yourusername/intellipaat.git
cd intellipaat

# Step 2: Recreate environment, it auto install all packages
conda env create -f environment.yml

# Step 3: Activate
conda activate intellipaat

# Step 4: Register Jupyter kernel
python -m ipykernel install --user --name intellipaat --display-name "Python (intellipaat)"

# Step 5: Done! Launch Jupyter
jupyter lab
```

---

</br>

## Folder Structure

```
INTELLIPAAT
│
├── SQL             --> SQL notes, handson files
│
├── Python          --> Python notes & exercises
│
├── Scripts         --> This is not course content
│
├── environment.yml --> Replicate my anaconda env on your device
│
└── README.md       --> This file
```

---

</br>

## Topics Covered So Far

### SQL

- DDL, DQL, DML, DCL, TCL
- Constraints, Joins, Functions, Triggers
- Aggregations, Indexes, Stored Procedures

### Python & ML

- Anaconda, Jupyter Notebook
- Python basics

</br>

---

</br>
