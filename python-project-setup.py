#!/usr/bin/env python

'''
Scaffold a new Python project.

Jani Karhunen 13.07.2017

Docs:
- https://docs.python.org/3/library/venv.html

'''

import argparse
import os
import sys
import venv


def main(args):
    ''' Main entry point of the app.
    Set home path for development projects. '''
    devhome = args.devhome.strip()

    ''' Read desired project name, and make the name safe for creating a directory. '''
    project = args.project_name.strip()
    project = "".join([c for c in project if c.isalpha() or c.isdigit() or c == '_' or c == '-']).rstrip()

    ''' There should be at least one character in the project (directory) name. '''
    if (len(project) < 1):
        sys.exit('invalid_name')

    ''' Let's validate paths. '''
    if os.path.exists(devhome) and os.path.isdir(devhome):
        os.chdir(devhome)
        ''' Again, let's make sure we do not try to create a project dir, which already exists. '''
        if os.path.exists(project):
            sys.exit('already_exists')

        # Create project root
        os.mkdir(project)
        os.chdir(project)
        # work_dir = os.getcwd()

        ''' Create virtualenv in project dir, install Pip but do not install System Packages. '''
        venv.create('venv', system_site_packages=False, with_pip=True)

    sys.exit(project)


if __name__ == "__main__":
    ''' This is executed when run from the command line. '''
    parser = argparse.ArgumentParser()

    # Project Home Directory
    parser.add_argument("devhome", help="The root path for Dev Projects")

    # Project name
    parser.add_argument("project_name", help="The Project name")

    args = parser.parse_args()
    main(args)
