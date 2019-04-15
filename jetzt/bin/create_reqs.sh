#!/usr/local/bin/zsh

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

echo "Creating requirements files based on installed dependencies..."
echo ""
echo "${GREEN}PROD dependencies > requirements.txt${NC}:"
python "$1/create_reqs.py" dep_type___PROD

echo ""
echo "${GREEN}DEV dependencies > requirements-dev.txt${NC}:"
python "$1/create_reqs.py" dep_type___DEV

echo ""
echo "${GREEN}Successfully created requirements files.${NC}"
