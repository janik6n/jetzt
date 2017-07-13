#!/bin/bash -e

echo "Hello! So happy you decided to scaffold a new project! Let's begin."
read -p 'Name your new project: ' project_name
mydir=$(python3 /Users/janik/Devs/Projects/scaffold-project/project-setup.py $DEVHOME "$project_name" 2>&1)

if [[ "$mydir" == "already_exists" ]]
then
	echo "Project path already exists. Let's not destroy that one."
elif [[ "$mydir" == "invalid_name" ]]
then
	echo "Invalid name (empty), please craft another."
else
	# echo "creating project at $mydir ..."
	mydir=$(echo $mydir | tr -d '\r')
	echo "Created new project directory: $DEVHOME$mydir"
	cd "$DEVHOME$mydir"
	# pwd
	. 'venv/bin/activate'
	echo "Virtualenv activated."
	# pip list -o --format=columns
	pip install -U setuptools
	pip install -U pip
	pip freeze > requirements.txt
	echo "Pip & setuptools upgraded to latest."
	pythonversion=$(python -V)
	echo ""
	echo "Base project creation complete."

	# read -p "Would you like to scaffold a specific project (y/n)? " additional_stuff
	# if [[ "$additional_stuff" == "y" || "$additional_stuff" == "Y" ]]
	# then
	# 	echo "Scaffolding further..."
	# else
	# 	echo "Project creation complete. Happy coding!"
	# fi

	echo "- Project dir is $DEVHOME$mydir"
	echo "- Running $pythonversion"
fi
