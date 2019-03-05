#!/usr/local/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Finding if package ${GREEN}$1${NC} is already installed..."
INSTALLEDPKG=$(pip freeze | grep -iwF "$1" | awk '{split($0,a,"=="); print a[1]}')

if echo "$INSTALLEDPKG" | grep -iwF "$1"; then
    echo "${GREEN}Package $INSTALLEDPKG is already installed.${NC}"
else
    echo "Installing package ${GREEN}$1${NC} as $1 dependency..."
    pip install $1
    if [[ "$2" == "DEV" ]]
    then
        pip freeze | grep -iF "$1" | awk '{gsub("==", ">=", $0); print}' >> requirements-dev.txt
        echo "${GREEN}Installation of package $1 is ready. Added $1 to requirements-dev.txt.${NC}"
    else
        pip freeze | grep -iF "$1" | awk '{gsub("==", ">=", $0); print}' >> requirements.txt
        echo "${GREEN}Installation of package $1 is ready. Added $1 to requirements.txt.${NC}"
    fi
fi
