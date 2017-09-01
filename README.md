# mycli

> ##### Command-line utility for software and devops engineers

## Install

You can install it either by cloning and manually installing it

```bash
$ git clone git@github.com:darwinz/My-CLI.git --depth=1 && cd My-CLI && ./installer.sh && cd .. && rm -rf My-CLI || echo >&2 "Clone or install failed with $?" && kill -INT $$
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
$ mycli apcheEdit
$ mycli docker_images
$ mycli cpu_hogs
$ mycli zend_restart_all
```


### Options

> `--help (-h)`
> `--version (-v)`
> `environment`
> `aliases`
> `aws`
> `file_operations`
> `git`
> `acd`
> `apache`
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
> `zend`

### Available Commands

> #### General

- ```get_version```

    Get the current installed mycli version

- ```upgrade```

    Upgrade mycli to the latest version


> #### Environment

- ```install_homebrew```

    Install homebrew locally if not installed already


> #### AWS

- ```aws_get_instance_ips [aws_profile]```

    Prints an unparsed list of EC2 instance IP addresses. Optional argument 'production' for prod info

- ```aws_get_instance_info [-p|--profile aws_profile] [-q|--query] ```

    Prints a parsed list of EC2 instances with key information bits (pattern should match part of an EC2 instance name)

- ```aws_ssh [IP address] [Keyname]```

    Connects to a specified EC2 instance using a specified keyname

- ```aws_elb_list_instances [-a|--app] [-e|--env|--environment]```

    List EC2 instance attached to an ELB.  No argument for interactive

- ```aws_connect [-a|--app] [-e|--env|--environment] [-s|--service] [-k|--keyname] [-n|--instance-number] [-c|--command]```

    Makes a SSH connection to an EC2 instance (or sends a command through SSH).  No argument for interactive


> #### File Operations

- ```trash [filepath]```

    Moves a local file to trash rather than rm'ing that file

- ```cdf```

    Change directory to frontmost window of MacOS Finder

- ```extract [filepath]```

    Extract most known archives with one command

- ```file_create```

    Create a file that contains random contents with a specified size and filepath (Interactive)

- ```encrypt [filepath]```

    Encrypt a file using a DES3 hash

- ```decrypt [filepath]```

    Decrypt a file that was encrypted using a DES3 hash

- ```ff [search]```

    Find file under the current working dir

- ```ffs [search]```

    Find file whose name starts with {search} under the current working dir

- ```ffe [search]```

    Find file whose name ends with {search} under the current working dir


> #### Git

- ```git a```

    Alias for *git add*

- ```git ap```

    Alias for *git add -p*

- ```git c```

    Alias for *git commit --verbose*

- ```git ca```

    Alias for *git commit -a --verbose*

- ```git cm```

    Alias for *git commit -m*

- ```git cam```

    Alias for *git commit -a -m*

- ```git m```

    Alias for *git commit --amend --verbose*

- ```git d```

    Alias for *git diff*

- ```git ds```

    Alias for *git diff --stat*

- ```git dc```

    Alias for *git diff --cached*

- ```git s```

    Alias for *git status -s*

- ```git co```

    Alias for *git checkout*

- ```git cob```

    Alias for *git checkout -b*

- ```git b```

    List git branches sorted by last modified

- ```git la```

    List git aliases


> #### Amazon Cloud Drive (ACD)

- ```acd_backup [volume/path] [acd_dir]```

    Backup specified local volume or directory path to Amazon Cloud Drive and path in ACD
    
    
> #### Apache

- ```apacheEdit```

    Alias for opening /etc/apache2/apache2.conf in default editor
    
- ```apacheRestart```

    Alias for restarting apache2 service
    
- ```editHosts```

    Alias for opening /etc/hosts in default editor
    
- ```herr```

    Tail the httpd error log. Alias for 'tail /var/log/httpd/error_log'
    
- ```apacheLogs```

    Alias for 'less +F /var/log/apache2/error_log'
    
- ```display_errors_on```

    Set display_errors to On in /etc/php5/apach2/php.ini
    
- ```display_errors_off```

    Set display_errors to Off in /etc/php5/apach2/php.ini
    
- ```httpHeaders [Uri]```

    Get HTTP headers for specified remote web page URI
    
- ```httpDebug [Uri]```

    Download a remote web page for a specified URI and show info on what took time


> #### Docker

- ```docker_host```

    Display DOCKER_HOST env var
    
- ```docker_remove_images```

    Force remove/destroy all existing local docker images
    
- ```docker_remove_processes```

    Force remove/destroy all existing local docker processes
    
- ```docker_images```

    Display all existing local docker images
    
- ```docker_processes```

    Display all existing local docker processes
    
- ```docker_start_zendserver```

    Start up a new local docker instance based on the official zend server docker image
    
- ```docker_eval```

    Display docker default environment variables


> #### ElasticSearch

- ```install_es```

    Install elasticsearch locally

- ```es_start```

    Start elasticsearch service locally
    
    
> #### Misc

- ```weather [zip code]```

    Get the weather for a specified zip code
    
- ```define [word]```

    Define a specified word using collinsdictionary.com


> #### Mongo

- ```mongo_local_start```

    Start local mongo
    
- ```mongo_port```

    Get the local port mongo is running on
    
    
> #### MySQL


> #### Node

- ```node_start [environment]```

    Start node server with specified environment config
    
    
> #### Notes

- ```notes_screen```

    Show info on how to use the screen utility on Linux systems
    
- ```notes_remote_form_post_with_file```

    Show info on how to post to a form with file using cURL
    

> #### Redis


> #### Ruby


> #### System

- ```memHogsTop```

    Show processes using the most memory using top

- ```memHogsPs```

    Show processes using the most memory using ps

- ```cpu_hogs```

    Show processes using the most CPU using ps
    
- ```topForever```

    Show running list of processes using top sorted by CPU usage
    
- ```ttop```

    Recommended 'top' invocation to minimize resources
    
- ```findPid [search term]```

    Find process by name/search term
    
- ```my_ps [search term]```

    Find process used by my user
    
- ```netCons```

    Show all open TCP/IP sockets
    
- ```lsock```

    Display open sockets
    
- ```lsockU```

    Display only open UDP sockets
    
- ```lsockT```

    Displays only open TCP sockets
    
- ```ipInfo0```

    Gets info on connections for en0
    
- ```ipInfo1```

    Gets info on connections for en1
    
- ```openPorts```

    Gets a list of all listening connections
    
- ```showBlocked```

    Gets all ipfw rules including blocked IPs
    
- ```hardware```

    List system hardware
    
- ```cleanupDS```

    Delete .DS_Store files from current working directory recursively
    
- ```finderShowHidden```

    Changes flag in Finder to show hidden files
    
- ```finderHideHidden```

    Changes flag in Finder to hide hidden files
    
    
> #### VPN

- ```vpn_connect```

    Opens Cisco AnyConnect client, enters username and password and connects
    

> #### Zend

- ```zend_set_paths```

    Sets the Zend paths in $PATH and $CDPATH

- ```zend_restart_all```

    Restart all zend server services

- ```zend_restart_apache```

    Restart zend apache

- ```zend_restart_mysql```

    Restart zend mysql

- ```zend_vhosts_dir```

    Output zend vhosts directory

- ```zend_sites_dir```

    Output zend available sites directory
    
- ```llzv```

    List contents of zend vhosts directory
    
- ```llzs```

    List contents of zend available sites directory
    
- ```cdzv```

    Change directory to Zend Server vhosts directory
    
- ```cdzs```

    Change directory to Zend Server available sites directory
    
- ```vimzv [sitename]```

    Open vhost for \[sitename\] in vim
    
- ```vimhttpd```

    Open apache conf in vim
    
- ```vimphpini```

    Open php.ini in vim

