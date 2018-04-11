#!/bin/sh

####################################################
################  General Aliases ##################
####################################################

alias ll='ls -al'
alias cic='set completion-ignore-case On'
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgl='kubectl logs -f'
alias bi='bundle install'
alias brake='bundle exec rake'

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

function be
{
  bundle exec "$@"
}

########################################################
################  End General Aliases ##################
########################################################
