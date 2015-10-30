#!/bin/bash

print_help_and_exit () {
	echo "Usage: run-sentinels.sh MASTER_HOST MASTER_PORT";
	echo "Example: run-sentinels.sh localhost 6379";
	exit 2;
}

if [ -z "$1" ] || [ -z "$2" ]; then
    print_help_and_exit
fi

# stop running containers
docker stop redis_sentinel1
docker stop redis_sentinel2
docker stop redis_sentinel3

# remove existing containers
docker rm redis_sentinel1
docker rm redis_sentinel2
docker rm redis_sentinel3

# start docker containers
docker run -d -p 26379:26379 --name=redis_sentinel1 -e REDIS_MASTER_PORT_6379_TCP_ADDR=$1 -e REDIS_MASTER_PORT_6379_TCP_PORT=$2 oberthur/redis-sentinel
docker run -d -p 26380:26379 --name=redis_sentinel2 -e REDIS_MASTER_PORT_6379_TCP_ADDR=$1 -e REDIS_MASTER_PORT_6379_TCP_PORT=$2 oberthur/redis-sentinel
docker run -d -p 26381:26379 --name=redis_sentinel3 -e REDIS_MASTER_PORT_6379_TCP_ADDR=$1 -e REDIS_MASTER_PORT_6379_TCP_PORT=$2 oberthur/redis-sentinel