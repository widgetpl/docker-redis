#!/bin/bash

# stop running container
docker stop redis-cluster-node1
docker stop redis-cluster-node2
docker stop redis-cluster-node3
docker stop redis-cluster-node4
docker stop redis-cluster-node5
docker stop redis-cluster-node6

# remove existing container
docker rm redis-cluster-node1
docker rm redis-cluster-node2
docker rm redis-cluster-node3
docker rm redis-cluster-node4
docker rm redis-cluster-node5
docker rm redis-cluster-node6

# start docker container
docker run -d --net=host --name=redis-cluster-node1 oberthur/redis-cluster:3.0.7 "/etc/redis.conf --port 6379"
docker run -d --net=host --name=redis-cluster-node2 oberthur/redis-cluster:3.0.7 "/etc/redis.conf --port 6379"
docker run -d --net=host --name=redis-cluster-node3 oberthur/redis-cluster:3.0.7 "/etc/redis.conf --port 6379"
docker run -d --net=host --name=redis-cluster-node4 oberthur/redis-cluster:3.0.7 "/etc/redis.conf --port 6379"
docker run -d --net=host --name=redis-cluster-node5 oberthur/redis-cluster:3.0.7 "/etc/redis.conf --port 6379"
docker run -d --net=host --name=redis-cluster-node6 oberthur/redis-cluster:3.0.7 "/etc/redis.conf --port 6379"

docker run -it oberthur/redis-tools /redis-trib-autoconfirm.rb create --replicas 1 \
	192.168.99.100:6379 \
	192.168.99.100:6380 \
	192.168.99.100:6381 \
	192.168.99.100:6382 \
	192.168.99.100:6383 \
	192.168.99.100:6384
