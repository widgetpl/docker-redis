#!/bin/bash

set -e

CL_RST='\e[0m'
CL_RED='\e[0;31m'
CL_BLU='\e[0;34m'

LEVEL_INFO="${CL_BLU}INFO${CL_RST} "
LEVEL_WARN="${CL_RED}WARN${CL_RST} "
LEVEL_ERROR="${CL_RED}ERROR${CL_RST}"

CAN_START=true

if [ -z "${CLUSTER_CONFIG}" ]; then

  echo "${LEVEL_ERROR} CLUSTER_CONFIG env variable not specified."
  CAN_START=false

else

  printf "Applying cluster configuration from CLUSTER_CONFIG:\n"
  while read -r line
  do
    printf "$line\n" >> nodes.tmp
  done <<< "$CLUSTER_CONFIG"

  while read -r line
  do
    eval echo $line
    eval echo $line >> nodes.conf
  done < nodes.tmp

  if [ -z "${REDIS_CONFIG}" ]; then

    echo "${LEVEL_INFO} CLUSTER_CONFIG env variable not specified, no more options will be applied"

  else

    printf "Applying redis configuration from REDIS_CONFIG:\n"

    while read -r line
    do

      printf "$line\n"
      printf "$line\n" >> /etc/redis.conf

    done <<< "$REDIS_CONFIG"

  fi

fi

if [ "${CAN_START}" = true ]; then

  if [ "$1" = 'redis-server' ]; then
    chown -R redis .
    exec gosu redis "$@"
  fi

  exec "$@"

else

    echo -e "${LEVEL_ERROR} Some of mandatory environment variables was not specified. Exiting"
    exit 1

fi
