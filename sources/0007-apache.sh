#!/bin/sh

############################################################
################  Apache-Related Functions #################
############################################################

alias apacheEdit='sudo $EDITOR /etc/apache2/apache2.conf'   # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo service apache2 restart'          # apacheRestart:    Restart Apache
alias editHosts='sudo $EDITOR /etc/hosts'                   # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'                  # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"       # Apachelogs:   Shows apache error logs

##  Turn display errors on in php.ini
function display_errors_on()
{
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\ndisplay_errors_on\n\nTurn display errors on in php.ini\n  No arguments\n  Usage example:  display_errors_on"
        kill -INT $$
    fi

    sed -i -e "s/display_errors.*/display_errors = On/" /etc/php5/apache2/php.ini
    sudo service apache2 restart
}

## Turn display errors off in php.ini
function display_errors_off()
{
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\ndisplay_errors_off\n\nTurn display errors off in php.ini\n  No arguments\n  Usage example:  display_errors_off"
        kill -INT $$
    fi

    sed -i -e "s/display_errors.*/display_errors = Off/" /etc/php5/apache2/php.ini
    sudo service apache2 restart
}

## Get HTTP headers for remote web page
## @argument web page URL
function httpHeaders ()
{
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nhttpHeaders\n\nGet HTTP headers for remote web page\n  @argument  \$1 web page URL\n  Usage example:  httpHeaders text.example.com"
        kill -INT $$
    fi

    /usr/bin/curl -I -L $@ ;
}

## Download a remote web page and show info on what took time
## @argument web page URL
function httpDebug ()
{
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nhttpDebug\n\nDownload a remote web page and show info on what took time\n  @argument  \$1 web page URL\n  Usage example:  httpDebug text.example.com"
        kill -INT $$
    fi

    /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ;
}

################################################################
################  End Apache-Related Functions #################
################################################################
