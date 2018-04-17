#!/usr/local/bin/zsh

echo "Hello! So happy you decided to scaffold a new project! Let's begin."
echo "Running version 0.4.0"
vared -p 'Name your new project: ' -c project_name

# echo "DEVHOME: $(pwd)"
# echo "Project name: $project_name"

mydir=$(python3 $DEVHOME/jetzt/python-project-setup.py $(pwd) "$project_name" 2>&1)

if [[ "$mydir" == "already_exists" ]]
then
	echo "Project path already exists. Let's not destroy that one."
elif [[ "$mydir" == "invalid_name" ]]
then
	echo "Invalid name (empty), please craft some fancy name."
else
	mydir=$(echo $mydir | tr -d '\r')
	echo "Created new project directory: $(pwd)/$mydir"
	cd "$(pwd)/$mydir"
	python3 -m venv venv
	source 'venv/bin/activate'
	echo "Virtualenv activated."
	pip install -U pip
	pip install -U setuptools
	echo "Pip & setuptools upgraded to latest."
	pythonversion=$(python -V)
	echo ""
	echo "Base project creation complete."

	vared -p "Would you like to scaffold a specific project (y/n)? " -c additional_stuff
	if [[ "$additional_stuff" == "y" || "$additional_stuff" == "Y" ]]
	then
		echo "Scaffolding further..."
		vared -p "What kind of project would yo like to do (flask / jupyter / pythonsls)? " -c project_type
		if [[ "$project_type" == "flask" ]]
		then
			echo "Installing requirements for a Flask project..."
			pip install -r $DEVHOME/jetzt/seeds/python/requirements-flaskapp.txt
			pip freeze > requirements.txt
		elif [[ "$project_type" == "jupyter" ]]
		then
			echo "Installing requirements for a jupyter project..."
			pip install -r $DEVHOME/jetzt/seeds/jupyter/requirements-jupyter.txt
			python -m ipykernel install --user
			pip freeze > requirements.txt
			echo "Creating project directories..."
			mkdir notebooks
			cd notebooks
			mkdir data
			echo "Copying seed files to project..."
			cp $DEVHOME/jetzt/seeds/jupyter/starting-point.ipynb $(pwd)/
			cd ..
			jupyter-notebook
		elif [[ "$project_type" == "pythonsls" ]]
		then
			echo "" > requirements.txt
			echo "Installing development dependencies..."
			spip install flake8 --dev
			echo "Copying seed files to project..."
			cp $DEVHOME/jetzt/seeds/python-serverless/handler.py $(pwd)/
			cp $DEVHOME/jetzt/seeds/python-serverless/serverless.yml $(pwd)/
			cp $DEVHOME/jetzt/seeds/python-serverless/README.md $(pwd)/
			echo "Initialize Node.js project..."
			npm init --yes
			npm install serverless-python-requirements
		else
			echo "Could not identify, what kind of project to scaffold."
			echo "Currently available options are:"
			echo "  - flask"
			echo "  - jupyter"
			echo "  - pythonsls"
		fi
	else
		echo "No further scaffolding."
	fi

	echo "Project creation complete. Happy coding!"

	echo "- Project dir is $(pwd)/$mydir"
	echo "- Running $pythonversion"
fi

# Unset variables (otherwise remembers them on the same terminal session in future runs!)
unset project_name
unset mydir
unset pythonversion
unset project_type
unset additional_stuff
