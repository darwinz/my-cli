#!/bin/sh

##################################################################
##############  Environment Variables and Functions ##############
##################################################################

## Vim as system default text editor
export EDITOR=/usr/bin/vim
export whichOS="$(uname -a | awk '{print $1}')"
export userDir="$(cd ~ && pwd)"
[ "${whichOS}" = "Darwin" ] && export userDir="$(builtin cd ~ && pwd)"
export githubUrl="git@github.com"
export myCliGitURL="${githubUrl}:darwinz/My-CLI.git"

########################################################
## Color declarations that can be used in Bash functions
########################################################
RED='\033[0;31m'
BLUE='\033[0;34m'
BLACK='\033[0;30m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BROWN='\033[0;33m'
LIGHT_GREY='\033[0;37m'
DARK_GREY='\033[0;30m'
YELLOW='\033[0;33m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

#################################################################################
#################################################################################
## Set up PATH and CDPATH if anything is missing from those environment variables
#################################################################################
#################################################################################
if [[ $PATH != */usr/local/bin* ]]
then
    export PATH=/usr/local/bin:$PATH
fi

if [[ $CDPATH != *mycli* ]]
then
    export CDPATH=/usr/local/bin/mycli:$CDPATH
fi

if [[ $CDPATH != *Projects* ]]
then
    export CDPATH=.:~:~/Projects:$CDPATH
fi

function install_homebrew
{
    rubyInstalled=$(which ruby)
    if [ -z "${rubyInstalled}" ]; then
      curl -L https://get.rvm.io | bash -s stable --rails --ruby=1.9.3
    fi
    rubyInstalled=$(which ruby)
    if [ -z "${rubyInstalled}" ]; then
      echo -e "${RED}** Ruby did not install properly **${NC}"
      kill -INT $$;
    fi

    brewInstalled=$(which brew)
    if [ -z "${brewInstalled}" ]; then
        ${rubyInstalled} -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brewInstalled=$(which brew)
    if [ -z "${brewInstalled}" ]; then
      echo -e "${RED}** Homebrew did not install properly **${NC}"
      kill -INT $$;
    fi

    caskInstalled=$(brew info cask)
    if [ -z "${caskInstalled}" ]; then
        ${brewInstalled} tap caskroom/cask
    fi
    caskInstalled=$(brew info cask)
    if [ -z "${caskInstalled}" ]; then
      echo -e "${RED}** Cask did not install properly **${NC}"
      kill -INT $$;
    fi
}

######################################################################
##############  End Environment Variables and Functions ##############
######################################################################
