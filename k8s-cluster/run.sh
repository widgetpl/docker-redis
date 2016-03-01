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

  while read -r line
  do
    printf "$line\n" >> nodes.tmp
  done <<< "$CLUSTER_CONFIG"

  while read -r line
  do
    eval echo $line >> nodes.conf
  done < nodes.tmp

fi

if [ "${CAN_START}" = true ]; then

  if [ "$1" = 'redis-server' ]; then
    chown -R redis .
    exec gosu redis "$@"
  fi

  exec "$@"

else

    echo -e "$i{LEVEL_ERROR} Some of mandatory environment variables variables was not specified. Exiting"
    exit 1

fi
