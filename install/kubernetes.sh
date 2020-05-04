#!/bin/sh

separator

read -r -p "Do you want to install Kubernetes? [y/N] " response
response=${response}
if [[ $response =~ ^(yes|y)$ ]]
then
  echo "Installing Kubectl..."
  brew install kubectl
  echo "Installing minikube..."
  brew install minikube
else
  echo "skipped install Kubernetes"
fi
