#!/usr/local/bin/zsh

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

echo "Installed dependencies:"
echo ""
echo "${GREEN}PROD dependencies${NC}:"
python "$1/list_installed.py" dep_type___PROD

echo ""
echo "${GREEN}DEV dependencies${NC}:"
python "$1/list_installed.py" dep_type___DEV
