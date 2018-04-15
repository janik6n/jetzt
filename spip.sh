#!/usr/local/bin/zsh

# spip will wrap around pip and freeze to install
# Python packages in a managed way.

if [[ "$1" == "install" ]] then
  if [[ "$2" == "" ]] then
	  echo "Package name cannot be empty."
  else
    echo "Finding if already installed..."
    INSTALLEDPKG=$(pip freeze | grep -iwF "$2" | awk '{split($0,a,"=="); print a[1]}')

    if echo "$INSTALLEDPKG" | grep -iwF "$2"; then
      color=green
      message="\nPackage $INSTALLEDPKG is already installed."
      print -P "%F{$color}$message%f"
    else
      echo "Installing package $2"
      pip install $2
      if [[ "$3" == "--dev" ]] then
        pip freeze | grep -iF "$2" | awk '{gsub("==", ">=", $0); print}' >> requirements-dev.txt
        color=green
        message="\nInstallation of dev-package $2 is ready. Added $2 to requirements-dev.txt."
        print -P "%F{$color}$message%f"
      else
        pip freeze | grep -iF "$2" | awk '{gsub("==", ">=", $0); print}' >> requirements.txt
        color=green
        message="\nInstallation of package $2 is ready. Added $2 to requirements.txt."
        print -P "%F{$color}$message%f"
      fi
    fi
  fi
elif [[ "$1" == "list" ]] then
  color=green
  message="From requirements.txt"
  print -P "%F{$color}$message%f"
  cat requirements.txt
  echo "\n"
  message="From requirements-dev.txt"
  print -P "%F{$color}$message%f"
  cat requirements-dev.txt
  echo "\n"
  message="All packages via Pip:"
  print -P "%F{$color}$message%f"
  pip freeze
else
  echo "Unknown command: $1\n\nKnown are:\n- install [package_name] [add --dev to install as dev dependency]\n- list\n"
fi
