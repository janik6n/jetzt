#!/usr/local/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

req_file='requirements.txt'
if [[ "$2" == "DEV" ]]
then
    req_file='requirements-dev.txt'
fi

contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

echo "Finding if package ${GREEN}$1${NC} is already installed..."
INSTALLEDPKG=$(pip freeze | grep -iwF "$1" | awk '{split($0,a,"=="); print a[1]}')

if echo "$INSTALLEDPKG" | grep -iwF "$1"; then
    echo "${GREEN}Package $INSTALLEDPKG is already installed.${NC}"
else
    echo "Installing package ${GREEN}$1${NC} as $1 dependency..."

    if pip install $1; then
        if contains $1 "=="; then
            pip freeze | grep -iF "$1" >> $req_file
        else
            pip freeze | grep -iF "$1" | awk '{gsub("==", ">=", $0); print}' >> $req_file
        fi

        echo "${GREEN}Installation of package $1 is ready. Added $1 to $req_file.${NC}"
    else
        echo "${RED}Installation of package $1 failed. See error above.${NC}"
    fi
fi
