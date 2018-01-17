FROM debian:latest
MAINTAINER peter@pouliot.net
RUN \
    apt-get update -y && apt-get install -y git wget curl rsync openssh  ; \
    git clone -b stable https://github.com/github/backup-utils ; \
    cp /backup-utils/backup-config.example /backup-config

COPY Dockerfile /Dockerfile
VOLUME /data
WORKDIR /backup-utils/
ENTRYPOINT /backup-utils/bin
