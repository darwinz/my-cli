#!/bin/bash

###############################################################
#################       Git Aliases         ###################
###############################################################

# one-line log
git config --global alias.l 'log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
git config --global alias.lg 'log --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
git config --global alias.tlog 'log --stat --since="1 Day Ago" --graph --pretty=oneline --abbrev-commit --date=relative'

git config --global alias.rp 'rev-parse'

git config --global alias.a add
git config --global alias.ap 'add -p'
git config --global alias.c 'commit --verbose'
git config --global alias.ca 'commit -a --verbose'
git config --global alias.cm 'commit -m'
git config --global alias.cam 'commit -a -m'
git config --global alias.cma 'commit --amend --no-edit -m'
git config --global alias.m 'commit --amend --verbose'

git config --global alias.d diff
git config --global alias.ds 'diff --stat'
git config --global alias.dc 'diff --cached'
git config --global alias.dl '!git ll -1'
git config --global alias.dlc 'diff --cached HEAD^'

git config --global alias.s 'status -s'
git config --global alias.sh show
git config --global alias.co checkout
git config --global alias.cob 'checkout -b'

# branch related aliases
git config --global alias.ba 'branch -a'
git config --global alias.bd 'branch -d'
git config --global alias.bD 'branch -D'
git config --global alias.bdm '!git branch --merged | grep -v "*" | xargs -n 1 git branch -d'

git config --global alias.sq 'rebase -i'

git config --global alias.pl 'pull'
git config --global alias.pu 'push'
git config --global alias.puf 'push --force-with-lease'

git config --global alias.cf 'clean -f'
git config --global alias.cdf 'clean -d -f'

# list branches sorted by last modified
git config --global alias.b "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"

git config --global alias.st 'status -sb'

git config --global alias.rank 'shortlog -sn --no-merges'

# pr related aliases
git config --global alias.prc '!gh pr create -f'
git config --global alias.prl '!gh pr list'

# list aliases
git config --global alias.la "!git config -l | grep alias | cut -c 7-"

# list commits to branches in a nice format
git config --global alias.cbb "!git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# git flow aliases
git config --global alias.ffs "!git flow feature start"
git config --global alias.fff "!git flow feature finish"
git config --global alias.frs "!git flow release start"
git config --global alias.frf "!git flow release finish"

# traversal
git config --global alias.root "rev-parse --show-toplevel"

# hub as git alias (for fugitive and vim-rhubarb)
git config --global alias.hub '!hub'

###############################################################
#################      End Git Aliases       ##################
###############################################################
