#!/bin/bash

## Handle arguments, if any
while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -f|--full)
      FULL="TRUE"
      ;;
    -s|--shell)
      SHELL="${@:2}"
      ;;
    -h|--h|*help|*)
      echo "Arguments full (-f|--full), shell (-s|--shell)"
      kill -INT $$
      ;;
  esac

  shift # past argument or value
done

## Set some initial global variables
if [ ! -f "./sources/0001-environment.sh" ]; then
  echo "Missing environment source. Exiting..."
  kill -INT $$
fi
source ./sources/0001-environment.sh

if [ "${whichOS}" = "Darwin" ]; then
  thisDir=$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
  install_homebrew
else
  thisDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
fi

user_dir=$(cd ~ && pwd)
OPWD=$PWD

if [ ! -z "${FULL}" ]; then
  source ${thisDir}/install/mixins.sh
  source ${thisDir}/install/xcode.sh
  source ${thisDir}/install/brew.sh
  source ${thisDir}/install/docker.sh
  source ${thisDir}/install/npm.sh
  source ${thisDir}/install/fonts.sh
  source ${thisDir}/install/kubernetes.sh
  source ${thisDir}/install/python.sh
  source ${thisDir}/install/ruby.sh
  source ${thisDir}/install/git.sh
  setup_nvm
  setup_goenv
  setup_jenv
  setup_rapture
  setup_spark
  source ${thisDir}/install/go.sh
fi

function clean_bash_profile()
{
  if [ ! -e "${user_dir}/.bash_profile" ] && [ ! -e "${user_dir}/.bashrc" ]; then
    touch ${user_dir}/.bash_profile
    touch ${user_dir}/.bashrc
  fi

  BASH_PROFILE=$(test -e ${user_dir}/.bash_profile && echo "${user_dir}/.bash_profile")
  BASHRC=$(test -e ${user_dir}/.bashrc && echo "${user_dir}/.bashrc")

  declare -a BPARR=()
  [ ! -z "${BASH_PROFILE}" ] && BPARR+=("${BASH_PROFILE}")
  [ ! -z "${BASHRC}" ] && BPARR+=("${BASHRC}")
  for f in "${BPARR[@]}"
  do
    LINENUMS=""; while IFS=" "; read -ra LINE; do for i in "${LINE[@]}"; do export LINENUMS="$LINENUMS$i|"; done; done <<< "$(awk '/NODE_ENV/{ print NR; }' ${f})"
    [ "${whichOS}" = "Darwin" ] && [ ! -z "${LINENUMS}" ] && LINENUMS=${LINENUMS:0:${#LINENUMS}-1}
    [ "${whichOS}" = "Linux" ] && [ ! -z "${LINENUMS}" ] && LINENUMS="${LINENUMS::-1}"
    awk 'NR!~/^('"$LINENUMS"')$/' ${f} > ${user_dir}/tmp-bashrc
    LINENUMS=""; while IFS=" "; read -ra LINE; do for i in "${LINE[@]}"; do export LINENUMS="$LINENUMS$i|"; done; done <<< "$(awk '/NODE_CONFIG_DIR/{ print NR; }' ${f})"
    [ "${whichOS}" = "Darwin" ] && [ ! -z "${LINENUMS}" ] && LINENUMS=${LINENUMS:0:${#LINENUMS}-1}
    [ "${whichOS}" = "Linux" ] && [ ! -z "${LINENUMS}" ] && LINENUMS="${LINENUMS::-1}"
    awk 'NR!~/^('"$LINENUMS"')$/' ${user_dir}/tmp-bashrc > ${user_dir}/tmp-bashrc1
    LINENUMS=""; while IFS=" "; read -ra LINE; do for i in "${LINE[@]}"; do export LINENUMS="$LINENUMS$i|"; done; done <<< "$(awk '/NVM_DIR/{ print NR; }' ${f})"
    [ "${whichOS}" = "Darwin" ] && [ ! -z "${LINENUMS}" ] && LINENUMS=${LINENUMS:0:${#LINENUMS}-1}
    [ "${whichOS}" = "Linux" ] && [ ! -z "${LINENUMS}" ] && LINENUMS="${LINENUMS::-1}"
    awk 'NR!~/^('"$LINENUMS"')$/' ${user_dir}/tmp-bashrc1 > ${user_dir}/tmp-bashrc2
    cat ${user_dir}/tmp-bashrc2 > ${f}
    rm -f ${user_dir}/tmp-bashrc*
  done
}

function patch_bash_profile()
{
  clean_bash_profile

  if [ ! -e "${user_dir}/.bash_profile" ] && [ ! -e "${user_dir}/.bashrc" ]; then
    touch ${user_dir}/.bash_profile
    touch ${user_dir}/.bashrc
  fi

  BASH_PROFILE=$(test -e ${user_dir}/.bash_profile && echo "${user_dir}/.bash_profile")
  BASHRC=$(test -e ${user_dir}/.bashrc && echo "${user_dir}/.bashrc")

  declare -a BPARR=()
  [ ! -z "${BASH_PROFILE}" ] && BPARR+=("${BASH_PROFILE}")
  [ ! -z "${BASHRC}" ] && BPARR+=("${BASHRC}")
  for f in "${BPARR[@]}"
  do
    BP_CONTENTS="$(cat ${f})"
    [[ $BP_CONTENTS != *${user_dir}/.mycli* ]] && echo "source ${user_dir}/.mycli" >> ${f}
    if [ "${whichOS}" = "Darwin" ]; then
      [[ $BP_CONTENTS != *bash_completion* ]] && echo '[ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion' >> ${f}
    else
      [[ $BP_CONTENTS != *bash_completion* ]] && echo '[ -f /etc/bash_completion ] && source /etc/bash_completion' >> ${f}
    fi
    if [ ! -z "${NVM_INSTALLED}" ]; then
      [[ "${BP_CONTENTS}" != *"NVM_DIR"* ]] && echo 'export NVM_DIR="$HOME/.nvm"' >> ${f} && \
        echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> ${f}
    fi
    if [ ! -z "${NODE_INSTALLED}" ]; then
      [[ "${BP_CONTENTS}" != *"NODE_ENV"* ]] && echo "export NODE_ENV=\"local\"" >> ${f}
      [[ "${BP_CONTENTS}" != *"NODE_CONFIG_DIR"* ]] && echo "export NODE_CONFIG_DIR=\"${user_dir}/Projects/node_config\"" >> ${f}
    fi
  done
}

function patch_zsh()
{
  f="${user_dir}/.zshrc"
  if [ ! -e "${f}" ]; then
    touch ${f}
  fi
  ZSHRC_CONTENTS="$(cat ${f})"

  [[ $ZSHRC_CONTENTS != *${user_dir}/.mycli* ]] && echo "source ${user_dir}/.mycli" >> ${f}
  if [ "${whichOS}" = "Darwin" ]; then
    [[ $ZSHRC_CONTENTS != *bash_completion* ]] && echo '[ -f $(brew --prefix)/etc/bash_completion ] && source $(brew --prefix)/etc/bash_completion' >> ${f}
  else
    [[ $ZSHRC_CONTENTS != *bash_completion* ]] && echo '[ -f /etc/bash_completion ] && source /etc/bash_completion' >> ${f}
  fi
  if [ ! -z "${NVM_INSTALLED}" ]; then
    [[ "${ZSHRC_CONTENTS}" != *"NVM_DIR"* ]] && echo 'export NVM_DIR="$HOME/.nvm"' >> ${f} && \
      echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm' >> ${f}
  fi
  if [ ! -z "${NODE_INSTALLED}" ]; then
    [[ "${ZSHRC_CONTENTS}" != *"NODE_ENV"* ]] && echo "export NODE_ENV=\"local\"" >> ${f}
    [[ "${ZSHRC_CONTENTS}" != *"NODE_CONFIG_DIR"* ]] && echo "export NODE_CONFIG_DIR=\"${user_dir}/Projects/node_config\"" >> ${f}
  fi
}

function setup_nvm()
{
  if [ ! -d "~/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
    export NVM_INSTALLED="TRUE"
  else
    rm -rf ~/.nvm
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
  fi
}

function setup_jenv()
{
  jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-10.jdk/Contents/Home
  jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-9.jdk/Contents/Home
  jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
  jenv global 10.0.2
}

function setup_goenv()
{
  git clone https://github.com/syndbg/goenv.git $HOME/.goenv
  mkdir -p $HOME/go
}

function setup_rapture()
{
  wget -P ~/Downloads/ https://github.com/daveadams/go-rapture/releases/download/v2.0.0/rapture-darwin-amd64
  mv ~/Downloads/rapture-darwin-amd64 /usr/local/bin/rapture
  chmod u+x /usr/local/bin/rapture
}

function setup_spark()
{
  sudo mkdir -p /usr/local/spark
  sudo chown $(whoami) /usr/local/spark
  wget -P ~/Downloads/ https://archive.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.6.tgz
  tar xzvf ~/Downloads/spark-2.4.3-bin-hadoop2.6.tgz -C /usr/local/spark/
  ln -s /usr/local/spark/spark-2.4.3-bin-hadoop2.6 /usr/local/spark/current
}

function runCompile()
{
  if [ "${whichOS}" = "Darwin" ]; then
    brew install shc
    shc -f ${thisDir}/bin/mycli -o ${thisDir}/bin/mycli || { echo >&2 "mycli binary creation failed with $?"; exit 1; }
  else
    sudo add-apt-repository -y ppa:neurobin/ppa
    sudo apt-get update
    sudo apt-get install -y shc
    shc -f ${thisDir}/bin/mycli -o ${thisDir}/bin/mycli || { echo >&2 "mycli binary creation failed with $?"; exit 1; }
  fi
}

## Create the mycli executable
if [ -f "bin/mycli" ]; then
  rm -f bin/mycli
fi

sudo rm -f ${thisDir}/bin/mycli
touch ${thisDir}/bin/mycli
echo '#!/bin/bash' > ${thisDir}/bin/mycli

## Create the .mycli source file for bash profile
if [ -f "${user_dir}/.mycli" ]; then
  rm -f ${user_dir}/.mycli
fi
touch ${user_dir}/.mycli
echo "#!/bin/bash" > ${user_dir}/.mycli

cd ${thisDir}

if [ "${whichOS}" = "Darwin" ]; then
  files=($(builtin cd sources && ls))
else
  files=($(cd sources && ls))
fi

# Loop through SH files and add the contents to the mycli
for f in "${files[@]}"
do
  if [ -f "./sources/${f}" ]; then
    echo "Adding source ${f} to mycli..."
    tail -n +2 "./sources/${f}" >> bin/mycli
  fi

  # Add environment and aliases to the shell profile
  if [ "${f}" = "0001-environment.sh" ] || [ "${f}" = "0002-aliases.sh" ]; then
    tail -n +2 "./sources/${f}" >> ${user_dir}/.mycli
  fi
done
# Add the program contents to the mycli
tail -n +2 "./install/program.sh" >> bin/mycli

if [[ "${SHELL}" = *"bash" ]]; then
  patch_bash_profile
else
  patch_zsh

  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Install forgit
  hub clone wfxr/forgit ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  # Install zsh-syntax-highlighting
  hub clone zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

## Install MyCLI in /usr/local/bin/mycli
#make install || { echo >&2 "Clone failed with $?"; exit 1; }

## Create alias mcli
if [ -f "/usr/local/bin/mcli" ]; then
  ## In case there is some other binary file with the same name (mcli)
  mv /usr/local/bin/mcli /usr/local/bin/mcli-OLD
elif [ -L "/usr/local/bin/mcli" ]; then
  ## Remove the old symbolic link
  unlink /usr/local/bin/mcli
fi
ln -s /usr/local/bin/mycli /usr/local/bin/mcli

exec $SHELL

cd $OPWD
