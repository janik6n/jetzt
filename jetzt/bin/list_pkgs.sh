#!/usr/local/bin/zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "${GREEN}Listing installed Python packages${NC}:"
echo ""
echo "From ${GREEN}requirements.txt${NC}:"
cat requirements.txt

echo ""
echo "From ${GREEN}requirements-dev.txt${NC}:"
cat requirements-dev.txt
