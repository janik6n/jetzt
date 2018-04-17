# jetzt

*The docs below are for version 0.4.1*

Light-weight scaffold raiser for new Python development projects.

This is a tiny tool built with shell scripts and Python 3.6+ to automate repetitive manual tasks, when creating a new Python development project. What you will end up with, when using the tool?

1. A new project directory under your *current directory*.
1. New **active** *virtualenv* named `venv` with the System-level installed Python 3.6+ version.
1. The virtualenv will have `pip` and `setuptools` installed and updated to latest available versions.
1. A standard `requirements.txt` will also be created.

## Prerequisites

This has been tested on the following setup:

1. MacOS Sierra 10.12.6
1. Python 3.6+ (installed via *Homebrew*)
1. Zsh shell (with oh-my-zsh)

Things should probably work nicely on earlier (and even later) releases of macOS / OS X and on various Linux distros too. **Python 3.6+ is expected.**

- [Create project](#create-project)
- [Install Python packages](#install-python-packages)

## Create project

Create a new project.

### How to use?

1. Add new *environment variable* `DEVHOME` to your `.zshrc`.
    - e.g. `export DEVHOME='/Users/me/Projects/'`
2. Clone this repo to your local development machine, under `DEVHOME`.
3. Create shortcuts to the shell scripts in your `.zshrc`.
    - `alias jetzt='source /Users/me/Projects/scaffold-project/jetzt.sh'`
    - `alias spip='source /Users/me/Projects/scaffold-project/spip.sh'`
4. Source your `.zshrc` with `source .zshrc`.
5. Run the script with `jetzt` and follow the prompt.

### Scaffolding options

When asked, whether to scaffold further, by answering `y` the tool installs a baseline for a new project. Available options are explained below.

- [Python - Flask](#flask)
- [Python - Jupyter](#jupyter)
- [Python - Serverless](#python-serverless)

#### Python

The following Python projects can be scaffolded at this time.

##### Flask

Option `flask`.

Installs the following packages (latest available versions):

- Flask

##### Jupyter

Option `jupyter`.

Installs the following packages (latest available versions):

- jupyter + ipykernel
- pandas
- matplotlib
- seaborn

Creates directories for:

- notebooks
- notebooks/data

Copies the following Jupyter notebook to `notebooks`:

- https://github.com/janikarh/jetzt/blob/master/seeds/starting-point.ipynb

... and finally runs the notebook server.

##### Python Serverless

Option `pythonsls`.

Scaffolds a Serverless project with Python 3.6 runtime in AWS. For more info, read [the docs](seeds/python-serverless/README.md).

## Install Python packages

There is naturally the standard way of using *pip* to install dependencies, and manually add them to `requirements.txt`, etc.

*Jetzt* includes a shell script called `spip.sh`, which is a wrapper around *pip*. This is a little helper, which will manage your installed packages for you. Please read the following examples:

### Install a package with spip

The regular use case is to install a package, which is required in production environment too.

To install a package `requests`, run `spip install requests`. What does this do?

1. Installs the package *requests* (latest available version).
2. Adds the package `requests` to `requirements.txt` with a version requirement set to minimum of the currently installed version. The packages, which *requests* depends on, are *not* added.

Example of `requirements.txt`:

```
requests>=2.18.4
```

### Install a development package with spip

To install a development package `flake8`, which is **not** needed in production environment, run `spip install flake8 --dev`. What does this do?

1. Installs the package *flake8* (latest available version).
2. Adds the package `flake8` to `requirements-dev.txt` with a version requirement set to minimum of the currently installed version. The packages, which *flake8* depends on, are *not* added.

Example of `requirements-dev.txt`:

```
flake8>=3.5.0
```

## Contribution

You want to contribute to this little project? Raise an issue first, let's discuss about your idea.

## License

MIT.