FROM oberthur/redis-base:latest

MAINTAINER Konrad Król <k.krol@oberthur.com>

EXPOSE 26379

RUN sysctl vm.overcommit_memory=1
ADD sentinel.conf.template /etc/sentinel.conf
ADD start-sentinel.sh start-sentinel.sh
RUN chmod +x start-sentinel.sh
ENTRYPOINT ["./start-sentinel.sh"]