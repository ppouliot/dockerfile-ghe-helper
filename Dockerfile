FROM alpine:latest
MAINTAINER peter@pouliot.net

ENV GHE_VERSION 0.0.5
ENV JENKINS_VERSION 3.16
ENV JENKINS_CLI_VERSION 3.16
ENV PYPY_VERSION pypy3-v5.10.1-linux64
ENV LANG en_US.utf-8

USER root
ENV HOME /root
RUN \
apk add --no-cache \
    git wget curl rsync openssh \
    bash openssh-server vim \
    expect screen byobu \
    sudo ruby ruby-dev \
    gcc make bison bzip2 ca-certificates \
    libffi-dev gdbm-dev  openssl-dev yaml-dev \
    python3 python3-dev jq build-base \
    openjdk8-jre libbz2 sqlite-dev procps zlib-dev \
    ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc 

RUN \
    ln -s `which python3` /usr/local/bin/python \
    && ln -s `which pip3` /usr/local/bin/pip \
    && pip3 install argparse setuptools future jenkins-job-builder keyrings.alt Pygments stashy python-gitlab \
# To install from a release
#    && pip3 install https://git.generalassemb.ly/ga-admin-utils/ghe/releases/download/${GHE_VERSION}/ghe-${GHE_VERSION}.tar.gz 
# To install directly from git
#    && pip3 install git+https://git.generalassemb.ly/ga-admin-utils/ghe.git
# Installing downstream with some bug fixes.
    && pip3 install git+https://github.com/ppouliot/ghe.git

RUN gem install bundler 
RUN gem install github-pages jekyll rouge jekyll-redirect-from kramdown rdiscount sinatra 

RUN byobu-enable 
copy windows.byobu /root/.byobu/windows.tmux

RUN adduser -D gh-pages -h /home/gh-pages -s /bin/bash
RUN adduser -D gh-backup -h /home/gh-backup -s /bin/bash

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

ENV HOME /root
USER root
WORKDIR $HOME
COPY Dockerfile /Dockerfile
COPY motd /etc/motd
COPY ghe-startup.py /ghe-startup.py
COPY ghe-startup.sh /ghe-startup.sh
VOLUME /data
CMD /ghe-startup.sh
