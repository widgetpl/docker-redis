FROM oberthur/redis-base:latest

MAINTAINER Konrad Król <k.krol@oberthur.com>

EXPOSE 6379
RUN sysctl vm.overcommit_memory=1
ADD start-slave.sh start-slave.sh
RUN chmod +x start-slave.sh
ENTRYPOINT ["./start-slave.sh"]