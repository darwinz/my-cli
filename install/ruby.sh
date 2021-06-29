#!/bin/sh

separator
rbi 1.9.3-p551
rbi 2.4.1
rbi 2.5.0

small_separator
echo "set ruby 2.4.1 as global ruby version..."
rbenv global 2.4.1

gi git-up true
gi bundler true
gi sass
gi jekyll
gi rouge
gi colorls

