#!/bin/bash

if [ -z "$PORT" ]; then
    echo "PORT environment variable is not defined. Will use default port 6379";
    PORT='6379'
fi

exec /usr/local/bin/redis-server /etc/redis.conf --port $PORT