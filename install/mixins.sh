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

function bt() {
  small_separator
  if [[ "$3" != true ]]
  then
    read -r -p "Do you want to install $2? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'brew tap' $1
      brew tap $1
      echo 'brew install --cask' $2
      brew install --cask $2
    else
      echo "skipped brew install --cask $2"
    fi
  else
    echo 'brew tap' $1
    brew tap $1
    echo 'brew install --cask' $2
    brew install --cask $2
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

function yi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 yarn package? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'yarn global add' $1
      yarn global add $1
    else
      echo "skipped yarn global add $1"
    fi
  else
    echo 'yarn global add' $1
    yarn global add $1
  fi
}

function pi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 package? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'pip install' $1
      pip install $1
    else
      echo "skipped pip install $1"
    fi
  else
    echo 'pip install' $1
    pip install $1
  fi
}

function p3i() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 package? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'pip3 install' $1
      pip3 install $1
    else
      echo "skipped pip3 install $1"
    fi
  else
    echo 'pip3 install' $1
    pip3 install $1
  fi
}

function pyi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install python version $1? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'pyenv install' $1
      CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib" \
PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2 \
pyenv install -v $1
    else
      echo "skipped pyenv install $1"
    fi
  else
    echo 'pyenv install' $1
    CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include" \
LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib" \
PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2 \
pyenv install -v $1
  fi
}

function gg() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 package? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'go get' $1
      go get $1
    else
      echo "skipped go get $1"
    fi
  else
    echo 'go get' $1
    go get $1
  fi
}

function gi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install $1 package? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'go install' $1
      go install $1
    else
      echo "skipped go install $1"
    fi
  else
    echo 'go install' $1
    go install $1
  fi
}

function gei() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install go version $1? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'goenv install' $1
      goenv install -v $1
    else
      echo "skipped goenv install $1"
    fi
  else
    echo 'goenv install' $1
    goenv install -v $1
  fi
}

function ci() {
  echo 'cargo install' $1
  cargo install $1
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

function rbi() {
  small_separator
  if [[ "$2" != true ]]
  then
    read -r -p "Do you want to install ruby version $1? [y/N] " response
    response=${response}
    if [[ $response =~ ^(yes|y)$ ]]
    then
      echo 'rbenv install' $1
      rbenv install $1
    else
      echo "skipped rbenv install $1"
    fi
  else
    echo 'rbenv install' $1
    rbenv install $1
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
      echo 'brew install --cask' $1
      brew install --cask $1
    else
      echo "skipped brew cask install $1"
    fi
  else
    echo 'brew cask install' $1
    brew cask install $1
  fi
}
