# Jetzt

[![version](https://img.shields.io/pypi/v/jetzt.svg?style=flat)](https://pypi.org/project/jetzt/)
[![platform](https://img.shields.io/pypi/pyversions/jetzt.svg?style=flat)](https://pypi.org/project/jetzt/)
[![wheel](https://img.shields.io/pypi/wheel/jetzt.svg?style=flat)](https://pypi.org/project/jetzt/)
[![downloads](https://img.shields.io/pypi/dm/jetzt.svg?style=flat)](https://pypi.org/project/jetzt/)
[![license](https://img.shields.io/github/license/janikarh/jetzt.svg?style=flat)](https://github.com/janikarh/jetzt/blob/master/LICENSE)

Light-weight project manager for Python projects.

This is a tiny tool built to automate repetitive manual tasks, when creating a new Python development project and managing project dependencies. What you will end up with, when using *jetzt*?

1. A new **project directory** under your *current directory*.
1. A new *virtualenv* named `venv` under the project directory with the System-level installed Python 3.6+ version.
1. The virtualenv will have `pip` and `setuptools` installed and updated to latest available versions.
1. Additional packages will be installed based on the selected project type.
1. Depending on the project type, other resources may be created to initialize a new project.

## Prerequisites

This has been tested on the following setup:

1. MacOS Sierra 10.12.6 and newer
1. Python 3.6+ (installed via *Homebrew*)
1. Zsh shell (with oh-my-zsh)

Things should probably work nicely on other releases of macOS and on various Linux distros too. **Python 3.6+ and zsh are expected.**

[A changelog](https://github.com/janikarh/jetzt/blob/master/CHANGELOG.md) is maintained.

- [Create project](#create-new-project)
- [Install Python packages](#manage-python-packages)

## Create new project

Run `jetzt --scaffold` and follow the prompt. **Make sure**, you have set *environment variable* `JETZT_HOME` to point to a directory, which will hold the individual projects.

### Scaffolding options

You have couple of options for a new project.

Each project will have the following packages installed as *development dependencies*:

- flake8
- pytest
- jetzt

These will be listed in `requirements-dev.txt`.

#### Python - [Blank]

This scaffolding option is meant to be a good starting point for a generic Python project. This option will not install any additional packages.

#### Python - Flask

This scaffolding option is meant to be a good starting point for a new Flask-based webapp / API project. This option will install the following packages:

- Flask

These will be listed in `requirements.txt`.

#### Python - Jupyter

This scaffolding option is meant to be a good starting point for a new data science / analytics project. This option will install the following packages:

- jupyter + ipykernel
- pandas
- matplotlib
- seaborn

These will be listed in `requirements.txt`.

Also a `data`-directory will be created, and [this notebook](https://github.com/janikarh/jetzt/blob/master/jetzt/seeds/python_jupyter/starting-point.ipynb) will be copied to the project root (the notebook is included in the installation package).

After scaffolding, start a jupyter server by running `jupyter-notebook` in the project root directory.

## Manage Python packages

There is naturally the standard way of using *pip* to install dependencies, and manually add them to `requirements.txt`, etc.

*Jetzt* includes an option to install and manage packages for you. Please read the following examples:

### Install a package

To install a package `requests`, run `jetzt --install` and follow the prompt. You have an option to install the package as *a production dependency* or as *a development dependency*. What does all this mean, you might ask? Jetzt will:

1. Install the package *requests* (latest available version).
2. Add the package `requests` to `requirements.txt` with a version requirement set to minimum of the currently installed version. The packages, which *requests* depends on, are *not* added. If you selected `DEV` as a dependency type, the file `requirements-dev.txt` will be used instead.

**At the moment, you can only install one package at a time.**

Example of `requirements.txt`:

```
requests>=2.21.0
```

#### Version pinning:

To install a specific version of a package, add the version, just as you would with pip. For example: `requests==2.20.1`. This will pin the version in `requirements.txt` like so:

```
requests==2.20.1
```

### List installed packages

To list installed packages, run `jetzt --list`.


## License

MIT.
