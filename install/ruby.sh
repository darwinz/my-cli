#!/bin/sh

separator
echo "install ruby 1.9.3-p551..."
rbenv install 1.9.3-p551

small_separator
echo "set ruby 1.9.3-p551 as global ruby version..."
rbenv global 1.9.3-p551

gi git-up true
gi bundler true
gi sass
gi jekyll
gi rouge