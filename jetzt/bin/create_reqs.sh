#!/usr/local/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Creating requirements files based on installed dependencies..."
echo ""
echo "${GREEN}PROD dependencies > requirements.txt${NC}:"
python "$1/create_reqs.py" dep_type___PROD

echo ""
echo "${GREEN}DEV dependencies > requirements-dev.txt${NC}:"
python "$1/create_reqs.py" dep_type___DEV

echo ""
echo "${GREEN}Successfully created requirements files.${NC}"
