#!/bin/sh
# If you use RVM: Use rvm use system
# THEN
# sudo gem install twine
# It because XCODE want to run RVM as system

# If you are not using RVM:
# For installing twine need to use sudo gem install twine --user-install

if [ `gem list twine -i` == "true" ]; then
  twine generate-all-localization-files --format apple --create-folders "$(pwd)/SkyEng_Task/Localizations/strings.txt"  "$(pwd)/SkyEng_Task/Localizations/Languages/"
  
  python3 "$(pwd)/SkyEng_Task/Scripts/LocalizationsKeyGeneration.py"
else
  echo "Error Script! Twine not exist"
  exit -1
fi
