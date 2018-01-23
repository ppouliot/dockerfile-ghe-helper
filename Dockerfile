#FROM openjdk:9-jdk
#FROM library/ubuntu:latest
FROM alpine:latest
MAINTAINER peter@pouliot.net

ENV GHE_VERSION 0.0.5
ENV JENKINS_VERSION 3.16
ENV JENKINS_CLI_VERSION 3.16
#ENV PYPY_VERSION pypy2-v5.10.0-linux64
ENV PYPY_VERSION pypy3-v5.10.1-linux64

USER root
RUN \
apk add --no-cache \
    git wget curl rsync openssh \
    bash openssh-server vim \
    expect screen byobu \
    expect sudo ruby ruby-dev \
    gcc make bison bzip2 ca-certificates \
    libffi-dev gdbm-dev  openssl-dev yaml-dev \
    python3 python3-dev jq build-base \
    openjdk8-jre libbz2 sqlite-dev procps zlib-dev \
    ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc 
#    && ln -s `which python3` /usr/local/bin/python

RUN \
    ln -s `which python3` /usr/local/bin/python \
    && ln -s `which pip3` /usr/local/bin/pip \
    && pip3 install argparse setuptools future jenkins-job-builder keyrings.alt Pygments \
#    && pip3 install https://git.generalassemb.ly/ga-admin-utils/ghe/releases/download/${GHE_VERSION}/ghe-${GHE_VERSION}.tar.gz 
#    && pip3 install git+https://git.generalassemb.ly/ga-admin-utils/ghe.git
    && pip3 install git+https://github.com/ppouliot/ghe.git

RUN gem install bundler 
RUN gem install github-pages jekyll rouge jekyll-redirect-from kramdown rdiscount 

RUN adduser -D jenkins -h /home/jenkins  -s /bin/bash
RUN adduser -D gh-pages -h /home/gh-pages -s /bin/bash
RUN adduser -D gh-backup -h /home/gh-backup -s /bin/bash

RUN \
   echo -n "*** Installing Jenkins Slave and Client ***" \
   && curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_VERSION}/remoting-${JENKINS_VERSION}.jar \
   && curl --create-dirs -sSLo /usr/share/jenkins/cli.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/cli/${JENKINS_CLI_VERSION}/cli-${JENKINS_CLI_VERSION}-jar-with-dependencies.jar \
   && chmod 755 /usr/share/jenkins \
   && chmod 644 /usr/share/jenkins/slave.jar \
   && chmod 644 /usr/share/jenkins/cli.jar

ENV HOME /home/gh-pages
USER gh-pages
WORKDIR $HOME
RUN echo -n "*** Creating GH/GHE wiki/pages src directories ***" \
    && mkdir -p ghe.wiki ghe.pages gh.wiki gh.pages

ENV HOME /home/gh-backup
USER gh-backup
WORKDIR $HOME
RUN echo -n "*** Installing GitHub Backup Utils ***" && git clone -b stable https://github.com/github/backup-utils \
    && cp ./backup-utils/backup.config-example ./backup.config \
    && echo -n "*** Installing GitHub Platform Samples ***" \
    && git clone https://github.com/github/platform-samples 

USER root
ENV HOME /
WORKDIR $HOME
COPY Dockerfile /Dockerfile
COPY motd /etc/motd
COPY ghe-startup.py /ghe-startup.py
COPY ghe-startup.sh /ghe-startup.sh
VOLUME /data
CMD /ghe-startup.sh
