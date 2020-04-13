#!/bin/sh

separator

small_separator

read -r -p "Do you want to install Docker? [y/N] " response
response=${response}
if [[ $response =~ ^(yes|y)$ ]]
then
  echo "Install Docker..."
  open https://download.docker.com/mac/stable/Docker.dmg
else
  echo "skipped install Docker"
fi

