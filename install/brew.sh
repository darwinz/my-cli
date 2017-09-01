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
bi git true
bi wget true
bi bash-completion true
bi mongodb
bi redis