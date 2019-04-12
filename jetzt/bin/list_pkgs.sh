#!/usr/local/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Installed dependencies:"
echo ""
echo "${GREEN}PROD dependencies${NC}:"
python "$1/list_installed.py" dep_type___PROD

echo ""
echo "${GREEN}DEV dependencies${NC}:"
python "$1/list_installed.py" dep_type___DEV
