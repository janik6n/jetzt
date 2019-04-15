#!/usr/local/bin/zsh

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

# echo $1
# echo $2
# echo $3

echo "Removing ${GREEN}$2${NC} dependency ${GREEN}$1${NC}..."

if pip uninstall -y $1; then
    python "$3/update_metadata.py" package___"$1" action___REMOVE dep_type___"$2"
    echo "${GREEN}Removal of package $1 is ready.${NC}"
else
    echo "${RED}Removal of package $1 failed. See error above.${NC}"
fi

echo "Updating outdated dependency list..."
source "$3/bin/list_outdated_pkgs.sh" "$3"

echo ""
echo "Removal of ${GREEN}$1${NC} is complete."
