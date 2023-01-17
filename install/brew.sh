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
bi goenv
bi jenv true
bi Caskroom/cask/java true
bi git true
bi git-flow true
bi git bash-completion true
bi wget true
bi jq true
bi jo true
bi ncdu true
bi tldr true
bi bash-completion true
bi mongo
bi redis
bi imagemagick
bi awscli
bi heroku
bi ruby-build
bi watch
bi k9s
bi fzf
bi hub
bi gh
bi vaulted
bi yarn
bi neovim
bi tfenv
bi bat
bi stern
bi exa
bi peco
bi oh-my-posh
bi httpie
bi croc
bi ctags
bi lsd
bi rm-improved
bi zoxide
bi dust
bi ripgrep
bi fd
bi sd
bi procs
bi bottom
bi broot
bi tokei
bi eva

bt "homebrew/cask-fonts" font-hack-nerd-font
bt "homebrew/cask" bitbar
bt "teamookla/speedtest" speedtest
bt "adoptopenjdk/openjdk" adoptopenjdk8
bt "adoptopenjdk/openjdk" adoptopenjdk9
bt "adoptopenjdk/openjdk" adoptopenjdk10
bt "sachaos/todoist" todoist
