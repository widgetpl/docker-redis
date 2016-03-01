FROM redis:3.0.7

MAINTAINER Michal Dziedziela <michal.dziedziela@gmail.com>

COPY ./run.sh /run.sh
RUN chown redis:redis /run.sh && \
    chmod +x /run.sh
