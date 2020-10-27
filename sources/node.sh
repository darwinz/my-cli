#!/bin/bash

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM

function node_start() {
  env=${1}
  if [ "${#}" -ne 1 ]; then
    read -p "Which environment?" env
  fi
  export NODE_ENV=${env}
  node_running_ps=$(ps aux | grep "node server" | grep -v grep | awk '{print $2}')
  echo "${node_running_ps}"
  if [ ! -z "${node_running_ps}" ]; then
    kill -9 ${node_running_ps}
  fi
  node server >> server.log 2>&1 &
}
