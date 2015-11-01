FROM oberthur/redis-base:latest

MAINTAINER Konrad Król <k.krol@oberthur.com>

EXPOSE 6379
RUN sysctl vm.overcommit_memory=1
ADD start-standalone.sh start-standalone.sh
RUN chmod +x start-standalone.sh
ENTRYPOINT ["/start-standalone.sh"]