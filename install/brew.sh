#!/bin/sh

separator

small_separator
echo "update homebrew..."
brew update

small_separator
echo "upgrade homebrew..."
brew upgrade

bi node true
bi rbenv true
bi pyenv true
bi pyenv-virtualenv
bi jenv true
bi Caskroom/cask/java true
bi git true
bi git-flow true
bi git bash-completion true
bi wget true
bi jq true
bi ncdu true
bi tldr true
bi bash-completion true
bi mongodb
bi mongo
bi redis
bi imagemagick
bi awscli
bi awsebcli
bi heroku
bi ruby-build
bi watch
bi k9s
bi hub
bi github/gh/gh
bi vaulted

bt "homebrew/cask-fonts" font-hack-nerd-font
