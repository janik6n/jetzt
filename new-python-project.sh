#!/bin/bash -e

echo "Hello! So happy you decided to scaffold a new project! Let's begin."
read -p 'Name your new project: ' project_name
mydir=$(python3 $DEVHOME/scaffold-project/python-project-setup.py $DEVHOME "$project_name" 2>&1)

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

	read -p "Would you like to scaffold a specific project (y/n)? " additional_stuff
	if [[ "$additional_stuff" == "y" || "$additional_stuff" == "Y" ]]
	then
		echo "Scaffolding further..."
		read -p "What kind of project would yo like to do (flask, jupyter)? " project_type
		if [[ "$project_type" == "flask" ]]
		then
			echo "Installing requirements for a Flask project..."
			pip install Flask
			pip freeze > requirements.txt
		elif [[ "$project_type" == "jupyter" ]]
		then
			echo "Installing requirements for a jupyter project..."
			pip install jupyter
			python -m ipykernel install --user
			pip install pandas
			# pip install xlrd
			pip install matplotlib
			pip install seaborn
			pip freeze > requirements.txt
			mkdir notebooks
			mkdir data
			cd notebooks
			# download a jupyter notebook template from this same project
			curl -O https://raw.githubusercontent.com/JaniKarh/scaffold-project/master/seeds/starting-point.ipynb
			cd ..
			jupyter-notebook
		else
			echo "Could not identify, what kind of project to scaffold."
			echo "Options are: flask or jupyter."
		fi

	else
		echo "No further scaffolding."
	fi

	echo "Project creation complete. Happy coding!"

	echo "- Project dir is $DEVHOME$mydir"
	echo "- Running $pythonversion"
fi
