#!/usr/local/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

pip list --outdated --format=json > jetzt_check_outdated_pgs.json

echo "${GREEN}Listing outdated dependencies:${NC}"

echo "\n${GREEN}PROD dependencies${NC}:"
python "$1/check_for_updates.py" jetzt_check_outdated_pgs.json PROD DoNotDeletePipJson

echo "\n${GREEN}DEV dependencies${NC}:"
python "$1/check_for_updates.py" jetzt_check_outdated_pgs.json DEV DeletePipJson
