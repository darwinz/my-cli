#!/bin/sh

read -p "Install composer? (y/N)" install_composer

if [[ ${install_composer} =~ ^(yes|y)$ ]]
then
    if [ ! -f "/usr/local/bin/composer.phar" ]; then
        echo "Downloading composer...\n"
        curl -sS https://getcomposer.org/installer | php
        echo -e "Installing composer...\n"
        sudo mv composer.phar /usr/local/bin/
    fi

    alias composer="/usr/local/bin/composer.phar"
fi