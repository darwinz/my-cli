#!/bin/sh

separator
echo "install python 3.7.6..."
pyenv install 3.7.6

small_separator
echo "install python 3.8.1..."
pyenv install 3.8.1

pi poetry true
pi click true
pi jmespath true
pi mockito
pi requests true
pi environs true
pi elasticsearch

