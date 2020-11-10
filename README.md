# mycli

> ##### Command-line utility for software and devops engineers

## Install

Install by cloning and running 

```bash
make install
```

## Usage

```bash
$ mycli [options|command] [arguments]
```

### Usage Examples

```bash
$ mycli
$ mycli --help
$ mycli docker
$ mycli mysql
$ mycli aws_connect -a app1 -e dev1
$ mycli acd_backup
$ mycli docker_images
$ mycli cpu_hogs
```


### Options / Categories

> `--help (-h)`
> `--version (-v)`
> `environment`
> `aliases`
> `aws`
> `file_operations`
> `git`
> `acd`
> `docker`
> `elasticsearch`
> `misc`
> `mongo`
> `mysql`
> `node`
> `notes`
> `redis`
> `ruby`
> `system`
> `vpn`

### Help / Commands List

#### General

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `get_version`  | Get the current installed mycli version  | |
| `upgrade`  | Upgrade mycli to the latest version  | |


#### Environment

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `install_homebrew`  | Get the current installed ccli version  | |


#### AWS

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `aws_get_instance_ips`  | Prints an unparsed list of EC2 instance IP addresses  | Optional argument $1 'production' for prod info |
| `aws_get_instance_info -p $aws_profile -q $query`  | Prints an unparsed list of EC2 instances with info  | $aws_profile (-p, --profile) = app, $query (-q, --query) = query or keywords |
| `aws_ssh $ip $keyname`  | Connects to a specified EC2 instance using a specified keyname  | $1 = IP address, $2 = ssh key name (stored locally in ~/.ssh) |
| `aws_elb_list_instances -a $app -e $env`  | List EC2 instance attached to an ELB.  No argument for interactive  | $app (-a, --app) = app name, $env (-e, --env, --environment) = environment (dev1, etc.) |
| `aws_connect -a $app -e $env -s $service -k $keyname -n $instance-num -c $command`  | Makes a SSH connection to an EC2 instance (or sends a command through SSH).  No argument for interactive  | $app (-a, --app) = app name<br><br>$env (-e, --env, --environment) = environment (dev1, etc.)<br><br>$service (-s, --service) (**optional**) = service (if multiple services exist for an app)<br><br>$keyname (-k, --keyname) = name of pem keyfile (stored in ~/.ssh)<br><br>$instance-num (-n, --instance-number) (**optional**) = specific instance number from list (1, 2, etc.)<br><br>$command (-c, --command) (**optional**) = command to run through SSH |


#### File Operations

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `trash $1`  | Moves a local file to trash rather than rm'ing that file  | $1 = Filepath |
| `cdf`  | Change directory to frontmost window of MacOS Finder  | |
| `extract $1`  | Extract most known archives with one command  | $1 = Filepath |
| `file_create`  | Create a file that contains random contents with a specified size and filepath (Interactive)  | |
| `encrypt $1`  | Encrypt a file using a DES3 hash | $1 = Filepath |
| `decrypt $1`  | Decrypt a file that was encrypted using a DES3 hash | $1 = Filepath |
| `ff $1`  | Find file under the current working dir | $1 = Search query |
| `ffs $1`  | Find file whose name starts with {$1} under the current working dir | $1 = Search query |
| `ffe $1`  | Find file whose name ends with {$1} under the current working dir | $1 = Search query |


#### Amazon Cloud Drive (ACD)

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `acd_backup [volume/path] [acd_dir]`  | Alias for *git add* | $1 = Local dir path to backup, $2 = Dir path on remote ACD |
    
    
#### Docker

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `docker_host` | Display DOCKER_HOST env var | |
| `docker_remove_images` | Force remove/destroy all existing local docker images | |
| `docker_remove_processes` | Force remove/destroy all existing local docker processes | |
| `docker_images` | Display all existing local docker images | |
| `docker_processes` | Display all existing local docker processes | |
| `docker_start_zendserver` | Start up a new local docker instance based on the official zend server docker image | |
| `docker_eval` | Display docker default environment variables | |


#### ElasticSearch

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `install_es` | Install elasticsearch locally | |
| `es_start` | Start elasticsearch service locally | |
    
    
#### Misc

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `weather [zip code]` | Get the weather for a specified zip code | $1 = zip code |
| `define [word]` | Define a specified word using collinsdictionary.com | $1 = word to define |


#### Mongo

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `mongo_local_start` | Start local mongo | |
| `mongo_port` | Get the local port mongo is running on | |


#### MySQL


#### Node

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `node_start [environment]` | Start node server with specified environment config | $1 = node environment |
    
    
#### Notes

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `notes_screen` | Show info on how to use the screen utility on Linux systems | |
| `notes_remote_form_post_with_file` | Show info on how to post to a form with file using cURL | |


#### Redis


#### Ruby


#### System

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `memHogsTop` | Show processes using the most memory using top | |
| `memHogsPs` | Show processes using the most memory using ps | |
| `cpu_hogs` | Show processes using the most CPU using ps | |
| `topForever` | Show running list of processes using top sorted by CPU usage | |
| `ttop` | Recommended 'top' invocation to minimize resources | |
| `findPid [search term]` | Find process by name/search term | $1 = search term |
| `my_ps [search term]` | Find process used by my user | $1 = search term |
| `netCons` | Show all open TCP/IP sockets | |
| `lsock` | Display open sockets | |
| `lsockU` | Display only open UDP sockets | |
| `lsockT` | Displays only open TCP sockets | |
| `ipInfo0` | Gets info on connections for en0 | |
| `ipInfo1` | Gets info on connections for en1 | |
| `openPorts` | Gets a list of all listening connections | |
| `usedPort` | Shows information about any files (process) open on a given port | $1 = port |
| `showBlocked` | Gets all ipfw rules including blocked IPs | |
| `hardware` | List system hardware | |
| `cleanupDS` | Delete .DS_Store files from current working directory recursively | |
| `finderShowHidden` | Changes flag in Finder to show hidden files | |
| `finderHideHidden` | Changes flag in Finder to hide hidden files | |
    
    
#### VPN

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `vpn_connect` | Opens Cisco AnyConnect client, enters username and password and connects | |

