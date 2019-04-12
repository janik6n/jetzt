import os
import json
import pathlib
import subprocess
import sys

from bullet import Bullet, SlidePrompt, Input
from bullet import colors
import click
from colorama import Fore, init

init(autoreset=True)


def dump_jetzt_metadata(jetzt_metadata, dump_file):
    with open(dump_file, 'w') as dump:
        json.dump(jetzt_metadata, dump, indent=2, ensure_ascii=False)


def run_scaffold(jetzt_home=None, app_path=None, jetzt_metadata=None, jetzt_metadata_file='jetzt_metadata.json'):
    cli = SlidePrompt(
        [
            Input("What is the name of your project? ",
                  word_color=colors.foreground["yellow"]),
            Bullet("What kind of project would you like to scaffold? ",
                   choices=["Python - [Blank]", "Python - Flask", "Python - Jupyter"],
                   bullet=" >",
                   margin=2,
                   bullet_color=colors.bright(colors.foreground["cyan"]),
                   # background_color=colors.background["black"],
                   background_on_switch=colors.background["black"],
                   word_color=colors.foreground["white"],
                   word_on_switch=colors.foreground["white"]),
        ]
    )

    result = cli.launch()
    cli.summarize()

    project_name = ''
    project_type = ''

    for result_item in result:
        key, value = result_item
        if key == 'What is the name of your project? ':
            project_name = value
        elif key == 'What kind of project would you like to scaffold? ':
            project_type = value

    # Make project_name safe
    project_name = "".join([c for c in project_name if c.isalpha() or c.isdigit() or c == '_' or c == '-']).rstrip()

    ''' There should be at least one character in the project (directory) name. '''
    if (len(project_name) < 1):
        sys.exit(Fore.RED + 'The project_name should contain at least one character.')

    ''' Let's validate paths. '''
    if os.path.exists(jetzt_home) and os.path.isdir(jetzt_home):
        os.chdir(jetzt_home)
        ''' Again, let's make sure we do not try to create a project dir, which already exists. '''
        if os.path.exists(project_name):
            sys.exit(Fore.RED + 'The project directory already exists.')

        # Create project root
        os.mkdir(project_name)

    jetzt_metadata['project_name'] = project_name
    jetzt_metadata['project_type'] = project_type
    dump_jetzt_metadata(jetzt_metadata, f"{project_name}/{jetzt_metadata_file}")

    ''' Call a shell script to install packages etc. '''
    subprocess.call(f'source {app_path}/bin/jetzt_scaffold.sh {jetzt_home} {project_name} "{project_type}" "{app_path}"', shell=True)

    print(Fore.GREEN + 'Scaffold complete.')
    print('To jump in the new environment, run:')
    print(Fore.GREEN + f'cd {jetzt_home}/{project_name} && source venv/bin/activate')
    sys.exit()


def run_install(app_path=None, jetzt_metadata=None, jetzt_metadata_file='jetzt_metadata.json'):
    prompt_pkg_name = 'What package from PyPI would you like to install (single pkg)? '
    prompt_dep_type = 'PROD or DEV dependency? '
    cli = SlidePrompt(
        [
            Input(prompt_pkg_name, word_color=colors.foreground["yellow"]),
            Bullet(prompt_dep_type,
                   choices=["PROD", "DEV"],
                   bullet=" >",
                   margin=2,
                   bullet_color=colors.bright(colors.foreground["cyan"]),
                   background_on_switch=colors.background["black"],
                   word_color=colors.foreground["white"],
                   word_on_switch=colors.foreground["white"]),
        ]
    )

    result = cli.launch()
    cli.summarize()

    pkg_name = ''
    dep_type = 'PROD'

    for result_item in result:
        key, value = result_item
        if key == prompt_pkg_name:
            pkg_name = value
        elif key == prompt_dep_type:
            dep_type = value

    if (len(pkg_name) < 1):
        sys.exit(Fore.RED + 'The PyPI package name to be installed should contain at least one character.')

    subprocess.call(f'source {app_path}/bin/install_pypi_pkg.sh "{pkg_name}" "{dep_type}" "{app_path}"', shell=True)
    sys.exit()


def run_list(app_path=None, jetzt_metadata=None, jetzt_metadata_file='jetzt_metadata.json'):
    subprocess.call(f'source {app_path}/bin/list_pkgs.sh {app_path}', shell=True)
    sys.exit()


def run_list_outdated(app_path=None, jetzt_metadata=None, jetzt_metadata_file='jetzt_metadata.json'):
    subprocess.call(f'source {app_path}/bin/list_outdated_pkgs.sh {app_path}', shell=True)
    sys.exit()


@click.command()
@click.option('--scaffold', 'command', flag_value='scaffold', help='Scaffold a new project.')
@click.option('--install', 'command', flag_value='install', help='Install a new package from PyPI.')
@click.option('--list', 'command', flag_value='list', help='List installed dependencies.')
@click.option('--list-outdated', 'command', flag_value='list_outdated', help='List outdated dependencies.')
def app(command):
    # Directory, where the command is run.
    jetzt_home = os.getcwd()

    jetzt_metadata_file = 'jetzt_metadata.json'
    jetzt_metadata = {}
    if os.path.exists(jetzt_metadata_file):
        with open(jetzt_metadata_file) as jetzt_metadata_f:
            jetzt_metadata = json.load(jetzt_metadata_f)

    # This file's (installed) path.
    app_path = pathlib.Path(os.path.dirname(os.path.realpath(__file__)))

    if command is None:
        sys.exit(Fore.RED + 'Please provide a command to run. See --help for available options.')

    command = command.lower()
    if command == 'scaffold':
        run_scaffold(jetzt_home, app_path, jetzt_metadata, jetzt_metadata_file)
    elif command == 'install':
        run_install(app_path, jetzt_metadata, jetzt_metadata_file)
    elif command == 'list':
        run_list(app_path, jetzt_metadata, jetzt_metadata_file)
    elif command == 'list_outdated':
        run_list_outdated(app_path, jetzt_metadata, jetzt_metadata_file)
    else:
        sys.exit(Fore.RED + f'Unknown command: {command}. See available commands with --help.')


if __name__ == '__main__':
    app()
