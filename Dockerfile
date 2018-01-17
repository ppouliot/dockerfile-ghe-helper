FROM debian:latest
MAINTAINER peter@pouliot.net

ENV GHE_VERSION 0.0.5

RUN apt-get update -y && apt-get install -y git wget curl rsync ssh python3 python3-pip screen expect
RUN git clone -b stable https://github.com/github/backup-utils
RUN ln -s /backup-utils/bin/* /usr/local/bin/
RUN cp /backup-utils/backup.config-example /backup.config
RUN sudo pip install https://git.generalassemb.ly/ga-admin-utils/ghe/releases/download/$ENV:GHE_VERSION/ghe-$ENV:GHE_VERSION.tar.gz
COPY Dockerfile /Dockerfile
VOLUME /data
WORKDIR /backup-utils/bin
