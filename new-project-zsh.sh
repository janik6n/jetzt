#!/usr/local/bin/zsh

echo "Hello! So happy you decided to scaffold a new project! Let's begin."
echo "Running version 0.2.0"
vared -p 'Name your new project: ' -c project_name

echo "DEVHOME: $DEVHOME"
echo "Project name: $project_name"

mydir=$(python3 $DEVHOME/scaffold-project/python-project-setup.py $DEVHOME "$project_name" 2>&1)

if [[ "$mydir" == "already_exists" ]]
then
	echo "Project path already exists. Let's not destroy that one."
elif [[ "$mydir" == "invalid_name" ]]
then
	echo "Invalid name (empty), please craft some fancy name."
else
	# echo "mydir ok: $mydir"
	mydir=$(echo $mydir | tr -d '\r')
	echo "Created new project directory: $DEVHOME$mydir"
	cd "$DEVHOME$mydir"
	source 'venv/bin/activate'
	echo "Virtualenv activated."
	pip install -U setuptools
	pip install -U pip
	pip freeze > requirements.txt
	echo "Pip & setuptools upgraded to latest."
	pythonversion=$(python -V)
	echo ""
	echo "Base project creation complete."

	vared -p "Would you like to scaffold a specific project (y/n)? " -c additional_stuff
	if [[ "$additional_stuff" == "y" || "$additional_stuff" == "Y" ]]
	then
		echo "Scaffolding further..."
		vared -p "What kind of project would yo like to do (flask / jupyter / slspython)? " -c project_type
		if [[ "$project_type" == "flask" ]]
		then
			echo "Installing requirements for a Flask project..."
			pip install -r $DEVHOME/scaffold-project/seeds/python/requirements-flaskapp.txt
			pip freeze > requirements.txt
		elif [[ "$project_type" == "jupyter" ]]
		then
			echo "Installing requirements for a jupyter project..."
			pip install -r $DEVHOME/scaffold-project/seeds/python/requirements-jupyter.txt
			python -m ipykernel install --user
			pip freeze > requirements.txt
			echo "Creating project directories..."
			mkdir notebooks
			cd notebooks
			mkdir data
			echo "Copying seed files to project..."
			# download a jupyter notebook template from this same project
			# curl -O https://raw.githubusercontent.com/JaniKarh/scaffold-project/master/seeds/starting-point.ipynb
			cp $DEVHOME/scaffold-project/seeds/jupyter/starting-point.ipynb $DEVHOME$mydir/notebooks
			cd ..
			jupyter-notebook
		elif [[ "$project_type" == "slspython" ]]
		then
			echo "Installing requirements for a Serverless Python project..."
			pip install -r $DEVHOME/scaffold-project/seeds/serverless-python/requirements.txt
			pip freeze > requirements.txt
			echo "Installing development dependencies..."
			pip install -r $DEVHOME/scaffold-project/seeds/serverless-python/requirements-dev.txt
			pip freeze > requirements-dev.txt
			echo "Copying seed files to project..."
			cp $DEVHOME/scaffold-project/seeds/serverless-python/handler.py $DEVHOME$mydir
			cp $DEVHOME/scaffold-project/seeds/serverless-python/serverless.yml $DEVHOME$mydir
			cp $DEVHOME/scaffold-project/seeds/serverless-python/README.md $DEVHOME$mydir
			echo "Initialize Node.js project..."
			npm init --yes
			npm install serverless-python-requirements
		else
			echo "Could not identify, what kind of project to scaffold."
			echo "Currently available options are:"
			echo "  - flask"
			echo "  - jupyter"
			echo "  - slspython"
		fi
	else
		echo "No further scaffolding."
	fi

	echo "Project creation complete. Happy coding!"

	echo "- Project dir is $DEVHOME$mydir"
	echo "- Running $pythonversion"
fi

# Unset variables (otherwise remembers them on the same terminal session in future runs!)
unset project_name
unset mydir
unset pythonversion
unset project_type
unset additional_stuff
