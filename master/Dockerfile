FROM oberthur/redis-base:latest

MAINTAINER Konrad Król <k.krol@oberthur.com>

EXPOSE 6379
RUN sysctl vm.overcommit_memory=1
ENTRYPOINT ["/usr/local/bin/redis-server"]