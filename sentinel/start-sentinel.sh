#!/bin/bash

if [ -z "$REDIS_MASTER_PORT_6379_TCP_ADDR" ]; then
    echo "REDIS_MASTER_PORT_6379_TCP_ADDR not defined. Please run with --link or specify environment variables manually.";
    exit 2;
fi

if [ -z "$REDIS_MASTER_PORT_6379_TCP_PORT" ]; then
    echo "REDIS_MASTER_PORT_6379_TCP_PORT not defined. Please run with --link or specify environment variables manually.";
    exit 2;
fi

sed -i -e "s/MASTER_HOST/$REDIS_MASTER_PORT_6379_TCP_ADDR/g" ./etc/sentinel.conf
sed -i -e "s/MASTER_PORT/$REDIS_MASTER_PORT_6379_TCP_PORT/g" ./etc/sentinel.conf

exec /usr/local/bin/redis-sentinel /etc/sentinel.conf $*
