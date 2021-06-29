#!/bin/sh

############################################################
################  Docker-Related Functions #################
############################################################

#boot2docker start
#$(boot2docker shellinit)

#export DOCKER_HOST=tcp://`boot2docker ip`:2376
#export DOCKER_CERT_PATH=${userDir}/.boot2docker/certs/boot2docker-vm
#export DOCKER_TLS_VERIFY=1

## Display docker host environment variable
docker_host() {
	echo $DOCKER_HOST
}

docker_login() {
    aws ecr get-login --region us-east-1  | sed 's/-e none //' | bash
}

## Force remove docker images
docker_remove_images() {
	docker rmi $(docker images -q)
}

## Force remove docker processes
docker_remove_processes() {
	docker rm -f $(docker ps -a -q)
}

docker_remove_processes_by_filter() {
  if [ "$#" -lt 1 ]; then
    read -p "What is the filter to use? " filter
  else
    filter=$1
  fi

  docker rm $(docker stop $(docker ps -a -q --filter ancestor=$filter --format="{{.ID}}"))
}

## Display docker images
docker_images() {
	docker images
}

## Display docker processes
docker_processes() {
	docker ps -a
}

docker_start_zendserver() {
	docker run -d -p 80:80 -p 10081:10081 -p 3306:3306 -e MYSQL_PORT=3306 -e MYSQL_USERNAME=${1} -e MYSQL_PASSWORD=${2} -e ZS_ADMIN_PASSWORD=admin -e ZEND_LICENSE_KEY=${3} -e ZEND_LICENSE_ORDER=${4} -v $HOME/Projects:${userDir}/Projects --name zendserver zend/php-zendserver
}

docker_eval() {
    eval "$(docker-machine env default)"
}

################################################################
################  End Docker-Related Functions #################
################################################################
