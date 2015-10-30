#!/bin/bash

print_help_and_exit () {
	echo "Usage: run-slave.sh MASTER_HOST MASTER_PORT";
	echo "Example: run-slave.sh localhost 6379";
	exit 2;
}

if [ -z "$1" ] || [ -z "$2" ]; then
    print_help_and_exit
fi

# stop running containers
docker stop redis_slave1
docker stop redis_slave2

# remove existing containers
docker rm redis_slave1
docker rm redis_slave2

# start docker containers
docker run -d -p 6380:6379 --name=redis_slave1 -e REDIS_MASTER_PORT_6379_TCP_ADDR=$1 -e REDIS_MASTER_PORT_6379_TCP_PORT=$2 oberthur/redis-slave
docker run -d -p 6381:6379 --name=redis_slave2 -e REDIS_MASTER_PORT_6379_TCP_ADDR=$1 -e REDIS_MASTER_PORT_6379_TCP_PORT=$2 oberthur/redis-slave