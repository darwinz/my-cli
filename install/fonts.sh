#!/bin/sh
separator

echo 'The easiest way to install all of the Google Web Fonts on OSX'
read -r -p "Do you want to install Google Web Fonts on OSX? [y/N] " response
response=${response}
if [[ $response =~ ^(yes|y)$ ]]
then
  curl https://raw.githubusercontent.com/qrpike/Web-Font-Load/master/install.sh | sh
else
  echo "skipped Google Web Fonts on OSX"
fi
