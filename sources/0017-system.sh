#!/bin/sh

#################################################################################
##############  System, Process, Memory, and Networking Functions  ##############
#################################################################################

function memHogsTop()
{
  top -l 1 -o rsize | head -20
}

function memHogsPs()
{
  ps wwaxm -o pid,stat,vsize,rss,time,command | head -10
}

function cpu_hogs()
{
  ps wwaxr -o pid,stat,%cpu,time,command | head -10
}

function topForever()
{
  top -l 9999999 -s 10 -o cpu
}

##  Recommended 'top' invocation to minimize resources
function ttop()
{
  top -R -F -s 10 -o rsize
}

##  Find process by name
##  @param $@ name or partial name of process to find
function findPid()
{
  lsof -t -c "$@" ;
}

##  Processes used by my user
##  @param  $@ (optional) additional arguments (-AaCcEefhjlMmrSTvwXx) (man ps)
function my_ps()
{
  ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ;
}

##  Show all open TCP/IP sockets
function netCons()
{
  lsof -i
}

##  Displays open sockets
function lsock()
{
  sudo /usr/sbin/lsof -i -P
}

##  Displays only open UDP sockets
function lsockU()
{
  sudo /usr/sbin/lsof -nP | grep UDP
}

##  Displays only open TCP sockets
function lsockT()
{
  sudo /usr/sbin/lsof -nP | grep TCP
}

##  Gets info on connections for en0
function ipInfo0()
{
  ipconfig getpacket en0
}

##  Gets info on connections for en1
function ipInfo1()
{
  ipconfig getpacket en1
}

##  Gets a list of all listening connections
function openPorts()
{
  sudo lsof -i | grep LISTEN
}

##  Gets all ipfw rules including blocked IPs
function showBlocked()
{
  sudo ipfw list
}

##  List system hardware
function hardware()
{
  if [ "${whichOS}" == "Darwin" ]; then
    /usr/sbin/system_profiler SPHardwareDataType
    diskutil list
  else
    lshw
  fi
}

##  Recursively delete .DS_Store files in current working directory
function cleanupDS()
{
  find . -type f -name '*.DS_Store' -ls -delete
}

##  Shows hidden files in Finder
function finderShowHidden()
{
  defaults write com.apple.finder ShowAllFiles TRUE
}

##  Hides hidden files in Finder
function finderHideHidden()
{
  defaults write com.apple.finder ShowAllFiles FALSE
}

function ping_ipv6()
{
  ping6 -I en0 ff02::1
}
