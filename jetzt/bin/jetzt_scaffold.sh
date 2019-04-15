#!/usr/local/bin/zsh

# echo $1
# echo $2
# echo $3
# echo $4

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

echo "${GREEN}Creating Python virtual environment and upgrading pip & setuptools...${NC}"
cd "$1/$2"
python3 -m venv venv
source 'venv/bin/activate'
pip install -U pip
pip install -U setuptools
echo "${GREEN}Pip & setuptools upgraded to latest versions.${NC}"
pythonversion=$(python -V)

if [[ "$3" == "Python - [Blank]" ]]
then
    echo "${GREEN}Installing requirements for a blank Python project...${NC}"
    source "$4/bin/install_pypi_pkg.sh" flake8 DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" pytest DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" jetzt DEV "$4"
    # echo "" > requirements.txt
elif [[ "$3" == "Python - Flask" ]]
then
    echo "${GREEN}Installing requirements for a Flask project...${NC}"
    source "$4/bin/install_pypi_pkg.sh" flake8 DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" pytest DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" jetzt DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" flask PROD "$4"
elif [[ "$3" == "Python - Jupyter" ]]
then
    echo "${GREEN}Installing requirements for a Jupyter project...${NC}"
    source "$4/bin/install_pypi_pkg.sh" flake8 DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" pytest DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" jetzt DEV "$4"
    source "$4/bin/install_pypi_pkg.sh" jupyter PROD "$4"
    source "$4/bin/install_pypi_pkg.sh" pandas PROD "$4"
    source "$4/bin/install_pypi_pkg.sh" matplotlib PROD "$4"
    source "$4/bin/install_pypi_pkg.sh" seaborn PROD "$4"
    # As of 9.4.2019 the fix is no longer needed.
    # Fix the current (as of 5.3.2019) issue with Tornado 6.x
    # https://github.com/jupyter/notebook/issues/2664
    # pip uninstall -y tornado
    # pip install tornado==5.1.1
    # Fix end.
    python -m ipykernel install --user
    # pip freeze > requirements.txt
    echo "Creating project directories..."
    mkdir data
    echo "Copying templates to project directories..."
    cp $4/seeds/python_jupyter/starting-point.ipynb $(pwd)/
    echo "${GREEN}Run Jupyter server in with 'jupyter-notebook' in project directory.${NC}"
elif [[ "$3" == "Python - Serverless" ]]
then
    echo "${GREEN}Installing requirements for a Serverless Python project...${NC}"
    echo "${RED}NOT IMPLEMENTED YET.${NC}"
    # echo "Installing development dependencies..."
    # echo "" > requirements.txt
    # pip install flake8
    # echo "Copying seed files to project..."
    # cp $4/seeds/python-serverless/handler.py $(pwd)/
    # cp $4/seeds/python-serverless/serverless.yml $(pwd)/
    # cp $4seeds/python-serverless/README.md $(pwd)/
    # echo "Initialize Node.js project..."
    # npm init --yes
    # npm install serverless-python-requirements
fi

echo "Project dir is $1/$2"
echo "Running $pythonversion"
python "$4/update_metadata.py" runtime___"$pythonversion" project_path___"$(pwd)"

# Unset variables (otherwise remembers them on the same terminal session in future runs!)
unset pythonversion

exit 0
