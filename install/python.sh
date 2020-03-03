#!/bin/sh

separator
pyi 3.7.6

small_separator
pyi 3.8.1

echo 'Setting python 3.7.6 as the global version...'
pyenv global 3.7.6

pi poetry true
pi click true
pi jmespath true
pi mockito
pi requests true
pi environs true
pi elasticsearch

