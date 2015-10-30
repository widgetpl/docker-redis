#!/bin/bash

# stop running container
docker stop redis

# remove existing container
docker rm redis

# start docker container
docker run -d -p 6379:6379 --name=redis oberthur/redis-standalone
