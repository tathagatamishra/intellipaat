# Anaconda

There are multiple way to use Anaconda and Jupyter Notebook

- Easy and quick way is to just use the Anaconda Cloud
  - <https://www.anaconda.com/app>
  - Just sign up and you are ready

---

</br>

## My Setup

### I Am Using Mini Anaconda

![!](https://dummyimage.com/14/ffd230/white?text=!) &nbsp;  Mini ≠ Mini, Mini = Freedom

- Python 3.13.12
- Mini Anaconda CLI
- VSCode

---

### Conda Steps

- Step 1: Open Anaconda Prompt

- Step 2: Update conda
  - `conda update`

- Step 3: Creating new environment
  - `conda create -n my-env-name python=3.13`
  - default env is base
  - The base environment is for GOD
  - never install project packages into base
  - we can use different py version for each env
  - we can create as many environments as we want
  - each completely isolated from the others
  - creating a new env install below packages

    | package                    |      size
    |----------------------------|-----------
    | bzip2-1.0.8                |     90 KB
    | ca-certificates-2025.12.2  |    125 KB
    | libexpat-2.7.5             |    120 KB
    | libffi-3.4.4               |    122 KB
    | libmpdec-4.0.0             |     95 KB
    | libzlib-1.3.1              |     64 KB
    | openssl-3.5.5              |    8.9 MB
    | packaging-25.0             |    190 KB
    | pip-26.0.1                 |    1.1 MB
    | python-3.13.12             |   15.9 MB
    | python_abi-3.13            |      6 KB
    | setuptools-80.10.2         |    1.7 MB
    | sqlite-3.51.2              |    917 KB
    | tk-8.6.15                  |    3.5 MB
    | tzdata-2026a               |    117 KB
    | ucrt-10.0.22621.0          |    620 KB
    | vc-14.3                    |     19 KB
    | vc14_runtime-14.44.35208   |    825 KB
    | vs2015_runtime-14.44.35208 |     19 KB
    | wheel-0.46.3               |     93 KB
    | xz-5.8.2                   |    265 KB
    | zlib-1.3.1                 |    113 KB
    | Total:                     |   34.9 MB

  - but we still need to install ML packages
    - ipykernel
    - jupyterlab
    - matplotlib
    - notebook
    - numpy
    - pandas
    - scikit-learn
    - seaborn

- Step 4: Check available environments
  - `conda env list`
  - OR
  - `conda info --envs`

- Step 5: Activate current environment
  - `conda activate my-env-name`

- Step 6: Installing ML packages
  - `conda install -c conda-forge numpy pandas matplotlib seaborn scikit-learn jupyterlab notebook ipykernel -y`
    - Total: 555.2 MB

- Step 7: Rename kernel
  - `python -m ipykernel install --user --name new_folder_name --display-name "my_kernel_name"`
  - naming our kernel to identify in Jupyter while creating notebook
    - information stored in
      - C:\Users\user_name\AppData\Roaming\jupyter\kernels\new_folder_name\kernel.json

- Step 8: Verify everything installed correctly
  - `python -c "import numpy, pandas, sklearn, matplotlib, seaborn; print('All good!')"`

- Step 9: Open VSCode
  - `Ctrl+Shift+P` ⟶ `Python: Select Interpreter` ⟶ itellipaat (3.13.12) Conda
  - OR
  - Open VSCode terminal ⟶ `conda activate my-env-name`

- Step 10: Open Jupyter Lab on Browser
  - `jupyter lab`

### Extra Steps

- Step 11: Sava Snapshot of current environment
  - `conda env export > environment.yml`

- Step 12: Now others can reuse my setup
  - `conda env create -f environment.yml`
  - `conda activate my-env-name`
  - `python -m ipykernel install --user --name new_folder_name --display-name "my_kernel_name"`

- Step 13: Deactivate the currently running env
  - `conda deactivate`

- Step 14: Delete a env
  - `conda env remove -n env-name`

</br>

---

</br>

## Steps to reuse my setup

```bash
# Step 1: Clone
git clone https://github.com/tathagatamishra/intellipaat.git
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

## What to do now

- Open terminal in vscode
- do `conda activate intellipaat`
- create new `.ipynb` file
- in the new ipynb at the top right corner click select kernel
- select `intellipaat (Python 3.13.12)`
