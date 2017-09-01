#!/bin/sh
separator

read -r -p "Do you have xCode on your machine? [y/N] " response
response=${response}
if [[ $response =~ ^(yes|y)$ ]]
then
  echo 'run $xcode-select --install'
  xcode-select --install
else
  echo 'abort $xcode-select --install'
  echo 'Install xCode in App Store!'
  exit
fi