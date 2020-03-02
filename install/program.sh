#!/bin/bash

#####################################################################################
#################### Program Setup and Usage Docs (Must Be Last) ####################
#####################################################################################

version="0.0.2"

if [ "${whichOS}" = "Darwin" ]; then
  thisDir=$(builtin cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
else
  thisDir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
fi

function get_version()
{
  echo "${version}"
}

function upgrade()
{
  if [ -d "${userDir}" ]; then
    rm -rf ${userDir}/tmp/mycli && mkdir -p ${userDir}/tmp/mycli
  else
    echo "There was a problem. Exiting..."
    kill -INT $$
  fi
  git clone -b master "${myCliGitURL}" --depth=1 ${userDir}/tmp/mycli
  OPWD=$PWD
  cd ${userDir}/tmp/mycli
  /bin/bash ${userDir}/tmp/mycli/installer.sh || echo >&2 "Clone or install failed with $?" && kill -INT $$
  cd ${OPWD}
  rm -rf ${userDir}/tmp/mycli
}

function usage()
{
  echo -e "\n${GREEN}mycli${NC} version `get_version` \n"
  echo -e "${GREEN}Usage: ${NC}"

  echo -e "mycli [options|command] [arguments]\n"
  echo -e "${GREEN}Options:${NC}"
  echo -e "${CYAN} --help ${NC}(-h) Display help/usage"
  echo -e "${CYAN} --version ${NC}(-v) Display mycli version\n"
  echo -e "${CYAN} --upgrade ${NC}(upgrade) Upgrade mycli to latest version\n"
  echo -e "${CYAN} [cli group (acd, apache, docker, ...)] ${NC} Display help/usage for a given cli group\n"
  echo -e "${GREEN}Available commands: ${NC}\n"

  usageOptions=("aliases" "acd" "apache" "docker" "environment" "file_operations" "git" "elasticsearch" "mongo" "mysql" "node" "notes" "redis" "ruby" "system" "vpn" "zend")

  for option in ${usageOptions[@]}
  do
    echo -e "$(available_commands ${option} | column -ts ::::)\n"
  done
}

function usage_single_group()
{
  echo -e "\n${GREEN}mycli${NC} version `get_version`\n"
  echo -e "${GREEN}Usage:${NC}"

  echo -e "mycli [options|command] [arguments]"
  echo -e "${YELLOW} - or - ${NC}"
  echo -e "mycli [options|command] [arguments]\n"
  echo -e "${GREEN}Available commands:${NC}\n"

  echo -e "$(available_commands ${1} | column -ts ::::)"
}

function available_commands()
{
  case ${1} in
    environment)
      echo -e "${YELLOW}environment${NC}"
      echo -e "${CYAN} > install_homebrew :::: ${NC}Install homebrew locally if not installed already"
      ;;
    aliases)
      echo -e "${YELLOW}aliases${NC}"
      echo -e "${CYAN} > numFiles :::: ${NC}Prints number of files in current dir"
      echo -e "${CYAN} > qfind :::: ${NC}Alias for 'find . -name'"
      echo -e "${CYAN} > editHosts :::: ${NC}Alias for 'sudo \${EDITOR} /etc/hosts'"
      echo -e "${CYAN} > cpuHogs :::: ${NC}Alias for 'ps wwaxr -o pid,stat,%cpu,time,command | head -10'"
      echo -e "${CYAN} > usedNetPorts :::: ${NC}Alias for 'lsof -i'"
      echo -e "${CYAN} > usedNetPorts :::: ${NC}Alias for 'lsof -i'"
      echo -e "${CYAN} > myip :::: ${NC}Alias for 'curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//''"
      if [ "${whichOS}" = "Darwin" ]; then
        echo -e "${CYAN} > flushDNS :::: ${NC}Alias for 'sudo killall -HUP mDNSResponder && dscacheutil -flushcache'"
        echo -e "${CYAN} > system_info :::: ${NC}Prints various system info"
      fi
      ;;
    aws)
      echo -e "${YELLOW}aws${NC}"
      echo -e "${CYAN} > install_aws :::: ${NC}Install and setup/configure AWS CLI"
      echo -e "${CYAN} > aws_get_instance_ips [aws-profile] :::: ${NC}Prints an unparsed list of EC2 instance IP addresses. Optional argument 'production' for prod info"
      echo -e "${CYAN} > aws_get_instance_info [-p|--profile] [-q|--query] :::: ${NC}Prints a parsed list of EC2 instances with key information bits (pattern should match part of an EC2 instance name)"
      echo -e "${CYAN} > aws_ssh [IP address] [Keyname] :::: ${NC}Connects to a specified EC2 instance using a specified keyname"
      echo -e "${CYAN} > aws_elb_list_instances [-a|--app] [-e|--env|--environment] :::: ${NC}List EC2 instance attached to an ELB.  No argument for interactive"
      echo -e "${CYAN} > aws_connect [-a|--app] [-e|--env|--environment] [-n|--instance-number] [-s|--service] [-k|--keyname] [-c|--command] :::: ${NC}Makes a SSH connection to an EC2 instance (or sends a command through SSH).  No argument for interactive"
      ;;
    file_operations)
      echo -e "${YELLOW}file operations${NC}"
      echo -e "${CYAN} > srch [path to search] [keyword] :::: ${NC}Search the local filesystem in path to search for keyword"
      echo -e "${CYAN} > cd [path] :::: ${NC}Override builtin cd - display specified path, change working directory to specified path, and then list all files in that directory"
      echo -e "${CYAN} > cdnl [path] :::: ${NC}Builtin cd with no list"
      echo -e "${CYAN} > mcd [path] :::: ${NC}Mkdir [path] and cd into that new dir"
      echo -e "${CYAN} > trash [filepath] :::: ${NC}Moves a local file to trash rather than rm'ing that file"
      echo -e "${CYAN} > cdf :::: ${NC}Change directory to frontmost window of MacOS Finder"
      echo -e "${CYAN} > cdpf :::: ${NC}Change directory to frontmost window of MacOS PathFinder"
      echo -e "${CYAN} > extract [filepath] :::: ${NC}Extract most known archives with one command"
      echo -e "${CYAN} > file_create :::: ${NC}Create a file that contains random contents with a specified size and filepath. No arguments for interactive"
      echo -e "${CYAN} > encrypt [filepath] :::: ${NC}Encrypt a file using a DES3 hash"
      echo -e "${CYAN} > decrypt [filepath] :::: ${NC}Decrypt a file that was encrypted using a DES3 hash"
      echo -e "${CYAN} > spotlight [search term] :::: ${NC}Search for a file using MacOS Spotlight's metadata"
      echo -e "${CYAN} > ff [search] :::: ${NC}Find file under the current working dir"
      echo -e "${CYAN} > ffs [search] :::: ${NC}Find file whose name starts with {search} under the current working dir"
      echo -e "${CYAN} > ffe [search] :::: ${NC}Find file whose name ends with {search} under the current working dir"
      echo -e "${CYAN} > file_get_wherefrom [search term] :::: ${NC}Find metadata about a file, including where it came from (e.g. where it was downloaded from)"
      ;;
    git)
      echo -e "${YELLOW}git${NC}"
      echo -e "${YELLOW}(git aliases)${NC}"
      echo -e "${CYAN} > git a :::: ${NC}git add"
      echo -e "${CYAN} > git ap :::: ${NC}git add -p"
      echo -e "${CYAN} > git c :::: ${NC}git commit --verbose"
      echo -e "${CYAN} > git ca :::: ${NC}git commit -a --verbose"
      echo -e "${CYAN} > git cm :::: ${NC}git commit -m"
      echo -e "${CYAN} > git cam :::: ${NC}git commit -a -m"
      echo -e "${CYAN} > git m :::: ${NC}git commit --amend --verbose"
      echo -e "${CYAN} > git d :::: ${NC}git diff"
      echo -e "${CYAN} > git ds :::: ${NC}git diff --stat"
      echo -e "${CYAN} > git dc :::: ${NC}git diff --cached"
      echo -e "${CYAN} > git s :::: ${NC}git status -s"
      echo -e "${CYAN} > git co :::: ${NC}git checkout"
      echo -e "${CYAN} > git cob :::: ${NC}git checkout -b"
      echo -e "${CYAN} > git b :::: ${NC}List git branches sorted by last modified"
      echo -e "${CYAN} > git la :::: ${NC}List git aliases"
      ;;
    acd)
      echo -e "${YELLOW}Amazon Cloud Drive (ACD)${NC}"
      echo -e "${CYAN} > acd_backup [volume/path] [acd_dir] :::: ${NC}Backup specified local volume or directory path to Amazon Cloud Drive and path in ACD"
      ;;
    apache)
      echo -e "${YELLOW}apache${NC}"
      echo -e "${CYAN} > apacheEdit :::: ${NC}Alias for opening /etc/apache2/apache2.conf in default editor"
      echo -e "${CYAN} > apacheRestart :::: ${NC}Alias for restarting apache2 service"
      echo -e "${CYAN} > editHosts :::: ${NC}Alias for opening /etc/hosts in default editor"
      echo -e "${CYAN} > herr :::: ${NC}Alias for 'tail /var/log/httpd/error_log'"
      echo -e "${CYAN} > apacheLogs :::: ${NC}Alias for 'less +F /var/log/apache2/error_log'"
      echo -e "${CYAN} > display_errors_on :::: ${NC}Set display_errors to On in /etc/php5/apach2/php.ini"
      echo -e "${CYAN} > display_errors_off :::: ${NC}Set display_errors to Off in /etc/php5/apach2/php.ini"
      echo -e "${CYAN} > httpHeaders [Uri] :::: ${NC}Get HTTP headers for specified remote web page URI"
      echo -e "${CYAN} > httpDebug [Uri] :::: ${NC}Download a remote web page for a specified URI and show info on what took time"
      ;;
    docker)
      echo -e "${YELLOW}docker${NC}"
      echo -e "${CYAN} > docker_host :::: ${NC}Display DOCKER_HOST env var"
      echo -e "${CYAN} > docker_remove_images :::: ${NC}Force remove/destroy all existing local docker images"
      echo -e "${CYAN} > docker_remove_processes :::: ${NC}Force remove/destroy all existing local docker processes"
      echo -e "${CYAN} > docker_images :::: ${NC}Display all existing local docker images"
      echo -e "${CYAN} > docker_processes :::: ${NC}Display all existing local docker processes"
      echo -e "${CYAN} > docker_start_zendserver :::: ${NC}Start up a new local docker instance based on the official zend server docker image"
      echo -e "${CYAN} > docker_eval :::: ${NC}Display docker default environment variables"
      ;;
    elasticsearch)
      echo -e "${YELLOW}elasticsearch${NC}"
      echo -e "${CYAN} > install_es :::: ${NC}Install elasticsearch locally"
      echo -e "${CYAN} > es_start :::: ${NC}Start elasticsearch service locally"
      ;;
    misc)
      echo -e "${YELLOW}misc${NC}"
      echo -e "${CYAN} > weather [zip code] :::: ${NC}Get the weather for a specified zip code"
      echo -e "${CYAN} > define [word] :::: ${NC}Define a specified word using collinsdictionary.com"
      ;;
    mongo)
      echo -e "${YELLOW}mongo${NC}"
      echo -e "${CYAN} > mongo_local_start :::: ${NC}Start local mongo"
      echo -e "${CYAN} > mongo_port :::: ${NC}Get the local port mongo is running on"
      ;;
    mysql)
      echo -e "${YELLOW}mysql${NC}"
      ;;
    node)
      echo -e "${YELLOW}node${NC}"
      echo -e "${CYAN} > node_start [environment] :::: ${NC}Start node server with specified environment config"
      ;;
    notes)
      echo -e "${YELLOW}notes${NC}"
      echo -e "${CYAN} > notes_screen :::: ${NC}Show info on how to use the screen utility on Linux systems"
      echo -e "${CYAN} > notes_remote_form_post_with_file :::: ${NC}Show info on how to post to a form with file using cURL"
      ;;
    redis)
      echo -e "${YELLOW}redis${NC}"
      ;;
    ruby)
      echo -e "${YELLOW}ruby${NC}"
      ;;
    system)
      echo -e "${YELLOW}system${NC}"
      echo -e "${CYAN} > memHogsTop :::: ${NC}Show processes using the most memory using top"
      echo -e "${CYAN} > memHogsPs :::: ${NC}Show processes using the most memory using ps"
      echo -e "${CYAN} > cpu_hogs :::: ${NC}Show processes using the most CPU using ps"
      echo -e "${CYAN} > topForever :::: ${NC}Show running list of processes using top sorted by CPU usage"
      echo -e "${CYAN} > ttop :::: ${NC}Recommended 'top' invocation to minimize resources"
      echo -e "${CYAN} > findPid [search term] :::: ${NC}Find process by name/search term"
      echo -e "${CYAN} > my_ps [search term] :::: ${NC}Find process used by my user"
      echo -e "${CYAN} > netCons :::: ${NC}Show all open TCP/IP sockets"
      echo -e "${CYAN} > lsock :::: ${NC}Display open sockets"
      echo -e "${CYAN} > lsockU :::: ${NC}Display only open UDP sockets"
      echo -e "${CYAN} > lsockT :::: ${NC}Displays only open TCP sockets"
      echo -e "${CYAN} > ipInfo0 :::: ${NC}Gets info on connections for en0"
      echo -e "${CYAN} > ipInfo1 :::: ${NC}Gets info on connections for en1"
      echo -e "${CYAN} > openPorts :::: ${NC}Gets a list of all listening connections"
      echo -e "${CYAN} > usedPort [port] :::: ${NC}Display info about any open file (process) on a given port"
      echo -e "${CYAN} > showBlocked :::: ${NC}Gets all ipfw rules including blocked IPs"
      echo -e "${CYAN} > hardware :::: ${NC}List system hardware"
      echo -e "${CYAN} > cleanupDS :::: ${NC}Delete .DS_Store files from current working directory recursively"
      echo -e "${CYAN} > finderShowHidden :::: ${NC}Changes flag in Finder to show hidden files"
      echo -e "${CYAN} > finderHideHidden :::: ${NC}Changes flag in Finder to hide hidden files"
      ;;
    vpn)
      echo -e "${YELLOW}vpn${NC}"
      echo -e "${CYAN} > vpn_connect :::: ${NC}Opens Cisco AnyConnect client, enters username and password and connects"
      ;;
    zend)
      echo -e "${YELLOW}zend${NC}"
      echo -e "${CYAN} > zend_set_paths :::: ${NC}Sets the Zend paths in \$PATH and \$CDPATH"
      echo -e "${CYAN} > zend_restart_all :::: ${NC}Restart all zend server services"
      echo -e "${CYAN} > zend_restart_apache :::: ${NC}Restart zend apache"
      echo -e "${CYAN} > zend_restart_mysql :::: ${NC}Restart zend mysql"
      echo -e "${CYAN} > zend_vhosts_dir :::: ${NC}Output zend vhosts directory"
      echo -e "${CYAN} > zend_sites_dir :::: ${NC}Output zend available sites directory"
      echo -e "${CYAN} > llzv :::: ${NC}List contents of zend vhosts directory"
      echo -e "${CYAN} > llzs :::: ${NC}List contents of zend available sites directory"
      echo -e "${CYAN} > cdzv :::: ${NC}Change directory to Zend Server vhosts directory"
      echo -e "${CYAN} > cdzs :::: ${NC}Change directory to Zend Server available sites directory"
      echo -e "${CYAN} > vimzv [sitename] :::: ${NC}Open vhost for [sitename] in vim"
      echo -e "${CYAN} > vimhttpd :::: ${NC}Open apache conf in vim"
      echo -e "${CYAN} > vimphpini :::: ${NC}Open php.ini in vim"
      ;;
    *) ;;
  esac

}

if [ "$#" -eq 0 ]; then
  echo "$(usage)"
  kill -INT $$
fi

case "${1}" in
  -h|--h|*help|*Help) echo "$(usage)" && kill -INT $$; ;;
  -v|--v|-V|--V|*version|*Version) echo "$(get_version)" && kill -INT $$ ;;
  --upgrade|upgrade|update) upgrade ;;
  environment|Environment|env) echo "$(usage_single_group environment)" && kill -INT $$ ;;
  aliases|Aliases) echo "$(usage_single_group aliases)" && kill -INT $$ ;;
  aws|Aws|AWS) echo "$(usage_single_group aws)" && kill -INT $$ ;;
  file_operations|file|File) echo "$(usage_single_group file_operations)" && kill -INT $$ ;;
  git|Git) echo "$(usage_single_group git)" && kill -INT $$ ;;
  acd|ACD) echo "$(usage_single_group acd)" && kill -INT $$ ;;
  apache|Apache) echo "$(usage_single_group apache)" && kill -INT $$ ;;
  docker|Docker) echo "$(usage_single_group docker)" && kill -INT $$ ;;
  elasticsearch|ElasticSearch|es) echo "$(usage_single_group elasticsearch)" && kill -INT $$ ;;
  misc|Misc) echo "$(usage_single_group misc)" && kill -INT $$ ;;
  mongo|Mongo|MongoDB|mongoDB) echo "$(usage_single_group mongo)" && kill -INT $$ ;;
  mysql|MySQL|Mysql) echo "$(usage_single_group mysql)" && kill -INT $$ ;;
  node|Node) echo "$(usage_single_group node)" && kill -INT $$ ;;
  notes|Notes) echo "$(usage_single_group notes)" && kill -INT $$ ;;
  redis|Redis) echo "$(usage_single_group redis)" && kill -INT $$ ;;
  ruby|Ruby) echo "$(usage_single_group ruby)" && kill -INT $$ ;;
  system|System) echo "$(usage_single_group system)" && kill -INT $$ ;;
  vpn|Vpn) echo "$(usage_single_group vpn)" && kill -INT $$ ;;
  zend|Zend) echo "$(usage_single_group zend)" && kill -INT $$ ;;
  *) ${@:1} ;;
esac

###########################################################
#################### End Program Setup ####################
###########################################################
