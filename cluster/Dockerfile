FROM oberthur/redis-base:latest

MAINTAINER Konrad Król <k.krol@oberthur.com>

EXPOSE 6379
RUN sysctl vm.overcommit_memory=1
ADD redis.conf /etc/redis.conf
ADD start-cluster-node.sh start-cluster-node.sh
RUN chmod +x start-cluster-node.sh
ENTRYPOINT ["/start-cluster-node.sh"]