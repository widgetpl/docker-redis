#!/bin/bash

# stop running container
docker stop redis_sentinel1
docker stop redis_sentinel2
docker stop redis_sentinel3
docker stop redis_slave1
docker stop redis_slave2
docker stop redis

# remove existing containers
docker rm redis_sentinel1
docker rm redis_sentinel2
docker rm redis_sentinel3
docker rm redis_slave1
docker rm redis_slave2
docker rm redis

# start docker containers
docker run -d -p 6379:6379 --name=redis oberthur/redis-standalone
docker run -d -p 6380:6379 --name=redis_slave1 --link=redis:redis_master oberthur/redis-slave
docker run -d -p 6381:6379 --name=redis_slave2 --link=redis:redis_master oberthur/redis-slave
docker run -d -p 26379:26379 --name=redis_sentinel1 --link=redis:redis_master oberthur/redis-sentinel
docker run -d -p 26380:26379 --name=redis_sentinel2 --link=redis:redis_master oberthur/redis-sentinel
docker run -d -p 26381:26379 --name=redis_sentinel3 --link=redis:redis_master oberthur/redis-sentinel
