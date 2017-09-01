#!/bin/sh

function separator() {
  echo ''
  echo ''
  echo '##################################################################'
  echo '##################################################################'
  echo ''
  echo ''
}

function small_separator() {
  echo '******************************************************************'
}

function bi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'brew install' $1
      brew install $1
    else
      echo "skipped brew install $1"
    fi
  else
    echo 'brew install' $1
    brew install $1
  fi
}

function ni() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 npm package? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'npm -g install' $1
      npm -g install $1
    else
      echo "skipped npm -g install $1"
    fi
  else
    echo 'npm -g install' $1
    npm -g install $1
  fi
}

function gi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 gem? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'sudo gem install' $1
      sudo gem install $1
    else
      echo "skipped sudo gem install $1"
    fi
  else
    echo 'sudo gem install' $1
    sudo gem install $1
  fi
}

function ai() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'brew cask install' $1
      brew cask install $1
    else
      echo "skipped brew cask install $1"
    fi
  else
    echo 'brew cask install' $1
    brew cask install $1
  fi
}