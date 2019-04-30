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
1. Depending on the project type, other resources may be created to initialize a new project (all from within this repo).

## Prerequisites

This has been tested on the following setups:

1. MacOS Sierra 10.12.6 and newer
    1. Python 3.6+ (installed via *Homebrew*)
    1. Zsh shell (with oh-my-zsh)
1. Fedora 29
    1. Python 3.6+
    1. Bash and Bourne shells

Things should probably work nicely on older releases of macOS / OS X and on various Linux distros too. **Python 3.6+ is expected.**

[A changelog](https://github.com/janikarh/jetzt/blob/master/CHANGELOG.md) is maintained.

- [Create new project](#create-new-project)
- [Manage Python dependencies](#manage-python-dependencies)
  - [Install a dependency](#install-a-dependency)
  - [List installed dependencies](#list-installed-dependencies)
  - [List outdated dependencies](#list-outdated-dependencies)
  - [Update outdated dependency](#update-outdated-dependency)
  - [Remove installed dependency](#remove-installed-dependency)
  - [Reinstall all dependencies](#reinstall-all-dependencies)
  - [Create requirements files](#create-requirements-files)

## Create new project

Run `jetzt --scaffold` in the directory, where you want to place your project directory, and follow the prompt.

### Scaffolding options

You have couple of options for a new project.

Each project will have the following packages installed as *development dependencies*:

- flake8
- pytest
- jetzt

These will be listed in `requirements-dev.txt`.

A metadata file `jetzt_metadata.json` is maintained, and this will be used to manage the project metadata, including installed dependencies. This should be committed to git along with the rest of the project files.

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

## Manage Python dependencies

All dependency management takes place within a *virtualenv* (created with `jetzt --scaffold`), so **make sure you have activated the project's environment before running these commands with `source venv/bin/activate`**. There is naturally the standard way of using *pip* to install dependencies, and manually add them to `requirements.txt`, etc.

*Jetzt* includes an option to install and manage the dependencies for you. Please continue reading.

### Install a dependency

To install a package `requests`, run `jetzt --install` and follow the prompt. You have an option to install the package as *a production dependency* or as *a development dependency*. What does all this mean, you might ask? Jetzt will:

1. Install the package *requests* (latest available version).
2. Add the package `requests` to `jetzt_metadata.json` with a version requirement set to minimum of the currently installed version. The packages, which *requests* depends on, are *not* added. You can install a dependency as a `DEV` dependency too.

**At the moment, you can only install one package at a time.**

Example of a defined dependency with a version (as a installation requirement, or as seen in `jetzt_metadata.json`):

```
requests>=2.21.0
```

**Version pinning:** To install a specific version of a package, add the version, just as you would with pip. For example: `requests==2.20.1`. This will pin the version like so:

```
requests==2.20.1
```

### List installed dependencies

To list installed dependencies, run `jetzt --list`.


### List outdated dependencies

To list outdated dependencies, run `jetzt --outdated`.

### Update outdated dependency

To update an outdated dependency, run `jetzt --update`. This will allow you to choose an outdated dependency to update. After the update, the command will update the outdated dependency list automatically.

### Remove installed dependency

To remove an installed dependency, run `jetzt --remove`. This will list all installed dependencies, and let's you choose which one you want to remove. After the update, the command will update the outdated dependency list automatically.

### Reinstall all dependencies

To reinstall all dependencies (excluding editable), run `jetzt --reinstall`. The dependency versions are pinned temporarily for installation, so yo will end up with the same version as before the reinstallation. *Make sure, you are in active virtualenv.*

### Create requirements files

Run `jetzt --create-requirements` to generate standard `requirements.txt` and `requirements-dev.txt` based on `jetzt_metadata.json`.

## License

MIT.
