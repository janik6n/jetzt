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

echo "Updating package ${GREEN}$1${NC} as $2 dependency..."

if pip install -U $1; then
    python "$3/update_metadata.py" package___"$1" action___INSTALL package_with_version___"$(pip freeze | grep -iF "$1")" dep_type___"$2"
    echo "${GREEN}Installation of package $1 is ready.${NC}"
else
    echo "${RED}Installation of package $1 failed. See error above.${NC}"
fi

echo "Updating outdated dependency list..."
source "$3/bin/list_outdated_pkgs.sh" "$3"

echo ""
echo "Update of${GREEN}$1${NC} complete."
