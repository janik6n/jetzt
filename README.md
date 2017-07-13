# scaffold-project

Light-weight scaffold raiser for new Python development projects.

This is a tiny tool built with Bash Shell and Python 3 to automate repetitive manual tasks, when creating a new Python development project. What you will end up with, when using the tool?

1. A new project directory under your `DEVHOME`.
1. New **active** *virtualenv* named `venv` with the System-level installed Python 3 version.
1. The virtualenv will have `pip` and `setuptools` installed and updated to latest available versions.
1. A standard `requirements.txt` will also be created.

## Prerequisites

This has been tested on the following setup:

1. MacOS Sierra 10.12.5
1. Python 3.6.1 (installed via *Homebrew*)

Things should probably work nicely on earlier releases of macOS / OS X and on Linux too. Python 3 is expected.

## Usage

1. Clone this repo to your local development machine.
1. Add new *environment variable* `DEVHOME` to your `.bash_profile`.
    - e.g. `export DEVHOME='/Users/me/Projects/'`
1. Optional: Create a shortcut for the Bash Shell Script to your `.bash_profile`.
    - e.g. `alias npp='. /Users/me/Projects/scaffold-project/new-python-project.sh'`
1. Run the script with `npp` (should you have selected this as an alias) and follow the prompt.

## Contribution

You want to contribute to this little project? Raise an issue first, let's discuss about your idea.

## License

MIT.