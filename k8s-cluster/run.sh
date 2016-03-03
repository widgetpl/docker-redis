#!/bin/bash

set -e

CL_RST='\e[0m'
CL_RED='\e[0;31m'
CL_BLU='\e[0;34m'

LEVEL_INFO="${CL_BLU}INFO${CL_RST} "
LEVEL_WARN="${CL_RED}WARN${CL_RST} "
LEVEL_ERROR="${CL_RED}ERROR${CL_RST}"

if [ -z "${CLUSTER_CONFIG}" ]; then

  echo "${LEVEL_WARN} CLUSTER_CONFIG env variable not specified."

else

  printf "${LEVEL_INFO} Applying cluster configuration from CLUSTER_CONFIG:\n"
  while read -r line
  do
    printf "$line\n" >> nodes.tmp
  done <<< "$CLUSTER_CONFIG"

  while read -r line
  do
    eval echo $line
    eval echo $line >> nodes.conf
  done < nodes.tmp
fi

if [ -z "${REDIS_CONFIG}" ]; then

  echo "${LEVEL_WARN} CLUSTER_CONFIG env variable not specified, no more options will be applied or use your own redis.conf file"

else

  printf "${LEVEL_INFO} Applying redis configuration from REDIS_CONFIG:\n"

  while read -r line
  do

    printf "$line\n"
    printf "$line\n" >> /etc/redis.conf

  done <<< "$REDIS_CONFIG"

fi


if [ "$1" = 'redis-server' ]; then
  chown -R redis .
  exec gosu redis "$@"
fi

exec "$@"
