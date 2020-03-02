#!/bin/sh

####################################################
################  General Aliases ##################
####################################################

user_dir=$(builtin cd ~ && pwd)

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

alias ll='ls -alh'
alias cic='set completion-ignore-case On'
alias addkey='eval $(ssh-agent) && ssh-add'
alias dirsizes='du -sch ./*'
function watchfile() {
  'watch -n 1 "cat $1"'
}

alias numFiles="echo $(ls -1 | wc -l)"
alias qfind="find . -name "
alias editHosts="sudo ${EDITOR} /etc/hosts"
alias cpuHogs="ps wwaxr -o pid,stat,%cpu,time,command | head -10"
alias usedNetPorts="lsof -i"
[ "${whichOS}" = "Darwin" ] && alias flushDNS="sudo killall -HUP mDNSResponder && dscacheutil -flushcache"
alias myip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"

if [ "${whichOS}" = "Darwin" ]; then
  system_info() {
    echo -e "\nYou are logged on ${RED}${HOSTNAME}"
    echo -e "\nAdditionnal information:${NC} " ; uname -a
    echo -e "\n${BLUE}Users logged on:${NC} " ; w -h
    echo -e "\n${RED}Current date :${NC} " ; date
    echo -e "\n${RED}Machine stats :${NC} " ; uptime
    echo -e "\n${RED}Current network location :${NC} " ; scselect
    echo -e "\n${RED}Public facing IP Address :${NC} " ; myip
    #echo -e "\n${RED}DNS Configuration:${NC} " ; scutil --dns
    echo
  }
fi

########################################################
################  End General Aliases ##################
########################################################
