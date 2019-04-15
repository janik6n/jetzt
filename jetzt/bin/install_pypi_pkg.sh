#!/usr/local/bin/zsh

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

# echo $1
# echo $2
# echo $3

# contains() {
#     string="$1"
#     substring="$2"
#     if test "${string#*$substring}" != "$string"
#     then
#         return 0    # $substring is in $string
#     else
#         return 1    # $substring is not in $string
#     fi
# }

echo "Checking if package ${GREEN}$1${NC} is already installed..."

if python "$3/check_if_installed.py" package___"$1" dep_type___"$2"; then
    echo "${GREEN}Package $INSTALLEDPKG is already installed as $2 dependency.${NC}"
else
    echo "Package is not installed. Installing package ${GREEN}$1${NC} as $2 dependency..."

    if pip install -U $1; then
        python "$3/update_metadata.py" package___"$1" action___INSTALL package_with_version___"$(pip freeze | grep -iF "$1")" dep_type___"$2"
        echo "${GREEN}Installation of package $1 is ready.${NC}"
    else
        echo "${RED}Installation of package $1 failed. See error above.${NC}"
    fi
fi
