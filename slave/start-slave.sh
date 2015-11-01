#!/bin/bash

if [ -z "$REDIS_MASTER_PORT_6379_TCP_ADDR" ]; then
    echo "REDIS_MASTER_PORT_6379_TCP_ADDR not defined. Please run with --link or specify environment variables manually.";
    exit 7;
fi

if [ -z "$PORT" ]; then
    echo "PORT environment variable is not defined. Will use default port 6379";
    PORT='6379'
fi

exec /usr/local/bin/redis-server --slaveof $REDIS_MASTER_PORT_6379_TCP_ADDR $REDIS_MASTER_PORT_6379_TCP_PORT --port $PORT $*