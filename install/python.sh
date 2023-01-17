#!/bin/sh

separator
pyi 3.7.6

small_separator
pyi 3.8.1

small_separator
pyi 2.7.17

echo 'Setting python 3.7.6 as the global version...'
pyenv virtualenv 3.7.6 defaultenv
pyenv global defaultenv 2.7.17
pyenv activate

pi pipenv true
pi awscli true
pi botocore true
pi boto3 true
pi click true
pi jmespath
pi requests true
pi environs true
pi elasticsearch
pi pymemcache true
pi black true
pi flake8 true
pi pandas
pi pyspark
pi pre-commit true
pi redis true
pi pytz true
p3i yq true
p3i termtosvg
p3i pynvim

