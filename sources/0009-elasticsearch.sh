#!/bin/bash

function es_start() {
  ~/elasticsearch-2.1.1/bin/elasticsearch >> ~/elasticsearch-2.1.1/logs/output.log 2>&1 &
}

function install_es() {
  whichsystem=$(uname -s)
  if [ "${whichsystem}" != "Darwin" ]; then
    echo -e "This script is not meant to be run in this environment\nExiting...\n\n"
    exit 1;
  fi
  install_homebrew
  $(which brew) update
  $(which brew) install elasticsearch
}