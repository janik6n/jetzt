#!/usr/local/bin/zsh

RED="`tput setaf 1`"
GREEN="`tput setaf 2`"
CYAN="`tput setaf 6`"
BOLD="`tput bold`"
NC="`tput sgr0`"

echo "Reinstalling all dependencies (with temporary version pinning for all dependencies)..."
echo ""
# echo "${GREEN}PROD dependencies > requirements.txt${NC}:"
python "$1/create_reqs.py" dep_type___PROD silent___YES versionpin___YES
# echo ""
# echo "${GREEN}DEV dependencies > requirements-dev.txt${NC}:"
python "$1/create_reqs.py" dep_type___DEV silent___YES versionpin___YES

# Uninstall all
echo "Removing all installed dependencies (excluding editable)..."
echo ""
pip freeze --exclude-editable | xargs pip uninstall -y

# Reinstall DEVs
echo "Processing DEV dependencies:"
while read in;
  do
  echo "Processing $in ..."
  if pip install -U $in; then
    # python "$1/update_metadata.py" package___"$in" action___INSTALL package_with_version___"$(pip freeze | grep -iF "$in")" dep_type___"DEV"
    echo "${GREEN}Installation of package $in is ready.${NC}"
  else
    echo "${RED}Installation of package $in failed. See error above.${NC}"
  fi;
done < requirements-dev.txt

# Reinstall PRODs
echo "Processing PROD dependencies:"
while read in;
  do
  echo "Processing $in ..."
  if pip install -U $in; then
    # python "$1/update_metadata.py" package___"$in" action___INSTALL package_with_version___"$(pip freeze | grep -iF "$in")" dep_type___"PROD"
    echo "${GREEN}Installation of package $in is ready.${NC}"
  else
    echo "${RED}Installation of package $in failed. See error above.${NC}"
  fi;
done < requirements.txt

rm requirements-dev.txt
rm requirements.txt

echo ""
echo "${GREEN}Successfully reinstalled all dependencies.${NC}"
