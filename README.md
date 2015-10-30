# Docker images containing Redis server

This repository contains docker images that allows to start Redis server instances of the following types:
- **master**
- **slave**
- **sentinel**

## Images types

There are the following images defined:

- **redis_base** - base image which other images inherits from
- **redis_standalone** - image containing standalone redis instance (master)
- **redis_slave** - image containing redis slave instance
- **redis_sentinel** - image containing redis slave instance

## Scripts

You can find example scripts in "scripts" directory:
- **build_all.sh** - builds all images with proper names
- **run_locally.sh** - starts multiple Redis instances locally (for testing purposes)
- **run_master.sh** - starts single Redis master instance
- **run_slaves.sh** - starts Redis slave instances
- **run_sentinels.sh** - starts Redis sentinels instances

## Customization

Environment variables may be used to customize/update redis default properties.
ENV vars should be passed when running container.
Below you can find a list of files with ENV vars.

For now redis-slave and redis-sentinel images requires the following ENV variables to be provided:
- REDIS_MASTER_PORT_6379_TCP_ADDR
- REDIS_MASTER_PORT_6379_TCP_PORT

They can be provided manually by using "-e" parameter while running "docker run" or by linking containers together using "--link" parameter.