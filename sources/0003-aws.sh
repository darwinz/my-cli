#!/bin/bash

##########################################################################
##############  AWS-Related Variables and Functions ######################
##########################################################################

export AWS_DEFAULT_PROFILE=default

if [ -f "/usr/local/bin/aws" ]; then
  awsBin="/usr/local/bin/aws"
else
  whichAws="$(which aws)"
  awsBin=$(echo "${whichAws}" | awk '{print $1;}')
fi

function install_aws()
{
  if [ -z "${awsBin}" ]; then
    install_homebrew
    brew install python3
    pip install --upgrade --user awscli
    aws configure
  fi
}

function aws_get_instance_ips()
{
  install_aws
  PROFILE="${1}"
  if [[ "$#" -lt 1 ]]; then
    PROFILE="default"
  fi
  echo -e "${GREEN}Getting EC2 instance IPs"$(test ! -z "${1}" && echo " in the ${1} environment" || echo "")${NC}
  aws ec2 describe-instances --profile ${PROFILE} | grep -i publicip
}

function aws_get_instance_info()
{
  install_aws
  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      -p|--profile) PROFILE="$2"; shift; ;;
      -q|--query) QUERY="$2"; shift; ;;
    esac

    shift # past argument or value
  done
  if [ -z "${PROFILE}" ]; then
    PROFILE="default"
  fi
  echo -e "${GREEN}Getting EC2 instance info"$(test ! -z "${1}" && echo " in the ${1} environment" || echo "")${NC}
  aws ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].[InstanceId,State,PublicIpAddress,PrivateIpAddress,LaunchTime,SecurityGroups,InstanceType,Tags[?Key=='Name'].Value]" \
    --filters "Name=tag:Name,Values=*${QUERY}*" --output json
}

function aws_ssh()
{
  install_aws
  USER="ubuntu"
  user_dir=$(builtin cd ~ && pwd)
  KEYNAME="${2}"
  if [ "$#" -lt 2 ]; then
    KEYNAME="aws"
  fi
  KEY="${user_dir}/.ssh/${KEYNAME}"

  if [ ! -f "${KEY}" ]; then
    read -p "Where is your ssh security key (${KEYNAME})? " filepath
    if [ ! -f "${filepath}" ]; then
      echo -e "${RED}Security key not found at location ${filepath}. Exiting...${NC}"
      kill -INT $$
    else
      cp -f ${filepath} ${KEY}
      chmod 400 ${KEY}
    fi
  fi

  HOST="$1"
  echo -e "${GREEN}ssh -i $KEY $USER@$HOST${NC}"
  ssh -i "$KEY" "$USER@$HOST"
}

function aws_elb_list_instances()
{
  install_aws
  USER="ubuntu"
  user_dir=$(cd ~ && pwd)
  if [ "${whichOS}" = "Darwin" ]; then
    user_dir=$(builtin cd ~ && pwd)
  fi

  unset LB_NAME && unset PROFILE && unset LB_TYPE && unset TG_NAME && unset KEYNAME

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      -lb|--lb-name) LB_NAME="$2"; shift; ;; # load balancer name
      -p|--profile) PROFILE="$2"; shift; ;; # aws profile name
      -lt|--lb-type) LB_TYPE="$2"; shift; ;; # load balancer type (alb|elb)
      -tg|--tg-name) TG_NAME="$2"; shift; ;; # target group name (if alb load balancer type)
      -k|--keyname) KEYNAME="$2"; shift; ;; # ssh key name
      -u|--user) USER="$2"; shift; ;; # ssh user
      -h|--h|*help|*)
        echo "Arguments lb-name (-lb|--lb-name), aws profile (-p|--profile), lb-type (-lt|--lb-type), target group name (-tg|--tg-name), key name (-k|--keyname), ssh user (-u|--user)"
        kill -INT $$
        ;;
    esac

    shift # past argument or value
  done

  KEYNAME=$(test -z "${KEYNAME}" && echo "aws" || echo "${KEYNAME}")
  PROFILE=$([[ -z "${PROFILE}" ]] && echo "default" || echo "${PROFILE}")
  LB=${LB_NAME}

  KEY="${user_dir}/.ssh/${KEYNAME}"

  if [ ! -f "${KEY}" ]; then
    read -p "$(echo -e "${YELLOW}Where is your ssh PEM key located (fullpath) for this environment?${NC}") " PEM_KEY
    cp -f ${PEM_KEY} ${KEY} && chmod 400 ${KEY}
  fi

  case "${LB_TYPE}" in
    alb)
      tg-name="${TG_NAME}"
      if [ -z "${TG_NAME}" ]; then
        TG_NAME="default"
      fi
      lbTgARN=$(${awsBin} elbv2 describe-target-groups --profile ${PROFILE} --names "${TG_NAME}" --query "TargetGroups[].TargetGroupArn[]" --output text)
      declare -a LB_INSTANCES=$(${awsBin} elbv2 describe-target-health --profile ${PROFILE} --target-group-arn "${lbTgARN}" --query "TargetHealthDescriptions[].Target[].Id[]" --output text) ;;
    *)
      declare -a LB_INSTANCES=$(${awsBin} elb describe-load-balancers --profile ${PROFILE} --load-balancer-name ${LB_NAME} --query "LoadBalancerDescriptions[].Instances[]" --output text) ;;
  esac

  declare -a ARR_INSTANCES=()
  for ec2Instance in $LB_INSTANCES
  do
    export ARR_INSTANCES=("${ARR_INSTANCES[@]}" "${ec2Instance}")
  done

  local numInstances=${#ARR_INSTANCES[@]}
  if [ "${#ARR_INSTANCES[@]}" -eq 1 ]; then
    INSTANCEIP=$(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].PublicIpAddress" --filters "Name=instance-id,Values=['$ec2Instance']" --output text)
    INSTANCE_LABEL=$(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" --filters "Name=instance-id,Values=['$ec2Instance']" --output text)
    echo -e "\n" ${ARR_INSTANCES} - ${INSTANCEIP} - ${INSTANCE_LABEL} "\n"
  elif [ "${#ARR_INSTANCES[@]}" -gt 1 ]; then
    echo -e "${GREEN}\nGetting instances...\n${NC}"
    declare -a INSTANCES=() && declare -a INSTANCEIPS=() && declare -a INSTANCE_LABELS=()
    for ec2Instance in $LB_INSTANCES
    do
      INSTANCEIPS=("${INSTANCEIPS[@]}" $(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].PublicIpAddress" --filters "Name=instance-id,Values=['$ec2Instance']" --output text))
      INSTANCE_LABELS=("${INSTANCE_LABELS[@]}" "$(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" --filters "Name=instance-id,Values=['$ec2Instance']" --output text)")
    done

    echo -e "${GREEN}\nThere are ${#ARR_INSTANCES[@]} instances on this load balancer\n${NC}"
    i=0
    for instance in $LB_INSTANCES
    do
      exampleInstanceId=${instance}
      echo ${instance} - ${INSTANCEIPS[$i]} - ${INSTANCE_LABELS[$i]}
      i=$i+1
    done
    echo ""
  else
    echo -e "${RED}No instances found on load balancer ${LB}${NC}" && kill -INT $$
  fi
}

function aws_connect()
{
  install_aws
  USER="ubuntu"
  user_dir=$(cd ~ && pwd)
  if [ "${whichOS}" = "Darwin" ]; then
    user_dir=$(builtin cd ~ && pwd)
  fi

  unset LB_NAME && unset PROFILE && unset LB_TYPE && unset TG_NAME && unset KEYNAME

  while [[ $# -gt 0 ]]
  do
    key="$1"

    case $key in
      -lb|--lb-name) LB_NAME="$2"; shift; ;;
      -p|--profile) PROFILE="$2"; shift; ;;
      -lt|--lb-type) LB_TYPE="$2"; shift; ;;
      -tg|--tg-name) TG_NAME="$2"; shift; ;;
      -n|--instance-number) NUMBER="$2"; shift; ;;
      -l|--all) ALL="TRUE"; ;;
      -c|--command)
        COMMAND="${@:2}"
        for (( i=0; i<${#COMMAND}; i++ )); do
          shift # past each word in argument
        done
        ;;
      -k|--keyname) KEYNAME="$2"; shift; ;;
      -u|--user) USER="$2"; shift; ;;
      -h|--h|*help|*)
        echo "Arguments app (-a|--app), environment (-e|--env|--environment), lb-type (-lt|--lb-type)"
        kill -INT $$
        ;;
    esac

    shift # past argument or value
  done

  KEYNAME=$(test -z "${KEYNAME}" && echo "aws" || echo "${KEYNAME}")
  PROFILE=$([[ -z "${PROFILE}" ]] && echo "default" || echo "${PROFILE}")
  LB=${LB_NAME}

  KEY="${user_dir}/.ssh/${KEYNAME}"

  if [ ! -f "${KEY}" ]; then
    read -p "$(echo -e "${YELLOW}Where is your ssh PEM key located (fullpath) for this environment?${NC}") " PEM_KEY
    cp -f ${PEM_KEY} ${KEY} && chmod 400 ${KEY}
  fi

  case "${LB_TYPE}" in
    alb)
      tg-name="${TG_NAME}"
      if [ -z "${TG_NAME}" ]; then
        TG_NAME="default"
      fi
      lbTgARN=$(${awsBin} elbv2 describe-target-groups --profile ${PROFILE} --names "${TG_NAME}" --query "TargetGroups[].TargetGroupArn[]" --output text)
      declare -a LB_INSTANCES=$(${awsBin} elbv2 describe-target-health --profile ${PROFILE} --target-group-arn "${lbTgARN}" --query "TargetHealthDescriptions[].Target[].Id[]" --output text) ;;
    *)
      declare -a LB_INSTANCES=$(${awsBin} elb describe-load-balancers --profile ${PROFILE} --load-balancer-name ${LB_NAME} --query "LoadBalancerDescriptions[].Instances[]" --output text) ;;
  esac

  declare -a ARR_INSTANCES=()
  for ec2Instance in $LB_INSTANCES
  do
    export ARR_INSTANCES=("${ARR_INSTANCES[@]}" "${ec2Instance}")
  done

  local numInstances=${#ARR_INSTANCES[@]}
  if [ "${#ARR_INSTANCES[@]}" -eq 1 ]; then
    HOST=$(aws ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].PublicIpAddress" --filters "Name=instance-id,Values=['$LB_INSTANCES']" --output text)
    echo -e -n "${GREEN}\nConnecting to instance ${ARR_INSTANCES[${NUMBER}]} on ${HOST}${NC}" && test ! -z "${COMMAND}" && echo -e "${GREEN}\n and running '${COMMAND}'...${NC}"
    if [ "${SFTP}" = "TRUE" ]; then
      echo -e "${GREEN}\n> sftp -i ${KEY} ${USER}@${HOST}\n${NC}"
      ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
      sftp -i ${KEY} ${USER}@${HOST}
    else
      echo -e -n "${GREEN}\n> ssh -i ${KEY} ${USER}@${HOST}${NC}" && test ! -z "${COMMAND}" && echo -e "${GREEN} '${COMMAND}'${NC}"
      echo -e "\n"
      ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
      test -z "${COMMAND}" && ssh -i ${KEY} ${USER}@${HOST} || ssh -i ${KEY} ${USER}@${HOST} "${COMMAND}"
    fi
  elif [ "${#ARR_INSTANCES[@]}" -gt 1 ]; then
    echo -e "${GREEN}\n\nThere are ${#ARR_INSTANCES[@]} running instances on load balancer '${LB}'.${NC}"
    if [ ! -z "${NUMBER}" ]; then
      HOST=$(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].PublicIpAddress" --filters "Name=instance-id,Values=['${ARR_INSTANCES[${NUMBER}]}']" --output text)
      echo -e -n "${GREEN}\nConnecting to instance ${ARR_INSTANCES[${NUMBER}]} on ${HOST}${NC}" && test ! -z "${COMMAND}" && echo -e "${GREEN} and running '${COMMAND}'...${NC}"
      if [ "${SFTP}" = "TRUE" ]; then
        echo -e "${GREEN}\n> sftp -i ${KEY} ${USER}@${HOST}\n${NC}"
        ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
        sftp -i ${KEY} ${USER}@${HOST}
      else
        echo -e -n "${GREEN}\n> ssh -i ${KEY} ${USER}@${HOST}${NC}" && test ! -z "${COMMAND}" && echo -e "${GREEN} '${COMMAND}'${NC}"
        ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
        test -z "${COMMAND}" && ssh -i ${KEY} ${USER}@${HOST} || ssh -i ${KEY} ${USER}@${HOST} "${COMMAND}"
      fi
      exit 0;
    fi

    echo -e "${GREEN}\nGetting and listing running instances...\n${NC}"
    declare -a INSTANCES=() && declare -a INSTANCEIPS=() && declare -a INSTANCE_LABELS=()
    for ec2Instance in $LB_INSTANCES
    do
      INSTANCEIPS=("${INSTANCEIPS[@]}" $(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].PublicIpAddress" --filters "Name=instance-id,Values=['$ec2Instance']" --output text))
      INSTANCE_LABELS=("${INSTANCE_LABELS[@]}" "$(${awsBin} ec2 describe-instances --profile ${PROFILE} --query "Reservations[].Instances[].Tags[?Key=='Name'].Value[]" --filters "Name=instance-id,Values=['$ec2Instance']" --output text)")
    done

    i=0
    for instance in $LB_INSTANCES
    do
      exampleInstanceId=${instance}
      echo $((i+1))") ${instance} - ${INSTANCEIPS[$i]} - ${INSTANCE_LABELS[$i]}"
      i=$i+1
    done
    test ! -z "${COMMAND}" && echo $((numInstances+1))") All server instances for this application ( 1 - ${numInstances} )"

    echo ""

    if [ ! -z "${COMMAND}" ]; then

      if [ -z "${ALL}" ]; then
        read -p "$(echo -e "${YELLOW}Which instance would you like to run the command '${COMMAND}' on? ( 1 - ${numInstances} ... or $((numInstances+1)) for all servers ):${NC}") " ITEMNUM
      fi

      if [ "${ITEMNUM}" = "$((numInstances+1))" ] || [ "${ALL}" = "TRUE" ]; then
        i=0
        for instance in $LB_INSTANCES
        do
          HOST=${INSTANCEIPS[$i]}
          echo -e "${GREEN}\Running '${COMMAND}' on instance ${instance} at ${HOST}...\n"
          echo -e "> ssh -i ${KEY} ${USER}@${HOST} '${COMMAND}'\n${NC}"
          ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
          ssh -i ${KEY} ${USER}@${HOST} "${COMMAND}"
          sleep 2
          i=$i+1
        done
      else
        ACTUALITEM=$((ITEMNUM-1))
        HOST=${INSTANCEIPS[$ACTUALITEM]}
        echo -e "${GREEN}\Running '${COMMAND}' on instance ${instance} at ${HOST}...\n"
        echo -e "> ssh -i ${KEY} ${USER}@${HOST} '${COMMAND}'\n${NC}"
        ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
        ssh -i ${KEY} ${USER}@${HOST} "${COMMAND}"
      fi

    else

      read -p "$(echo -e "${YELLOW}Which instance would you like to connect to? ( 1 - ${numInstances} ):${NC}") " ITEMNUM
      ACTUALITEM=$((ITEMNUM-1))
      HOST=${INSTANCEIPS[$ACTUALITEM]}
      echo -e -n "${GREEN}\nConnecting to instance ${ARR_INSTANCES[${ACTUALITEM}]} on ${INSTANCEIPS[$ACTUALITEM]}${NC}" && test ! -z "${COMMAND}" && echo "${GREEN} and running '${COMMAND}'...\n${NC}"

      if [ "${SFTP}" = "TRUE" ]; then
        echo -e "${GREEN}\n> sftp -i ${KEY} ${USER}@${HOST}\n${NC}"
        ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
        sftp -i ${KEY} ${USER}@${HOST}
      else
        echo -e "${GREEN}\n> ssh -i ${KEY} ${USER}@${HOST}\n${NC}"
        ssh -o StrictHostKeyChecking=no -l ${USER} ${HOST}
        test -z "${COMMAND}" && ssh -i ${KEY} ${USER}@${HOST} || ssh -i ${KEY} ${USER}@${HOST} "${COMMAND}"
      fi

    fi
  else
    echo -e "${RED}No instances found on load balancer '${LB}'${NC}" && kill -INT $$
  fi
}

##############################################################################
##############  End AWS-Related Variables and Functions ######################
##############################################################################
