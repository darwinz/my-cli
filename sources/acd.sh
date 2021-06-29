#!/bin/bash

###################################################################
##############  Amazon Cloud Drive Related Functions ##############
###################################################################

function install_acdcli() {
  acdcliBin=$(which acdcli)
  if [ -z "${acdcliBin}" ]; then
    install_homebrew
    brew install python3
    pip3 install --upgrade git+https://github.com/yadayada/acd_cli.git
  fi
}

function acd_backup() {
  if [ "$#" -lt "2" ]; then
    echo "Function requires two arguments, volume (or directory path) to backup and path in ACD"
    kill -INT $$
  fi

  install_acdcli

  volume=${1}
  acd_dir=${2}
  list=$(ls ${volume})

  echo ""
  echo "##########################################################################"
  echo "##################### -- $(date) -- ######################################"
  echo "##########################################################################"
  echo ""

  if [ -f ${volume} ]; then
    echo "Uploading ${volume} to Amazon Cloud Drive..."
    /usr/local/bin/acdcli upload ${volume} ${acd_dir}
  elif [ -d ${volume} ]; then
    for i in ${list[@]}
    do
      echo "${i} ${volume} ${acd_dir}"
      if [ -d ${volume}/${i} ] | [ -f ${volume}/${i} ]; then
        echo "Uploading contents of ${volume}/${i} to Amazon Cloud Drive..."
        /usr/local/bin/acdcli upload ${volume}/${i} ${acd_dir}
      fi
    done

  fi
}

#######################################################################
##############  End Amazon Cloud Drive Related Functions ##############
#######################################################################
