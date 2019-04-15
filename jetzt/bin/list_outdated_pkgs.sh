#!/usr/local/bin/zsh

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

pip list --outdated --format=json > jetzt_check_outdated_pgs.json

echo "${GREEN}Listing outdated dependencies:${NC}"

echo "\n${GREEN}PROD dependencies${NC}:"
python "$1/check_for_updates.py" jetzt_check_outdated_pgs.json PROD DoNotDeletePipJson

echo "\n${GREEN}DEV dependencies${NC}:"
python "$1/check_for_updates.py" jetzt_check_outdated_pgs.json DEV DeletePipJson
