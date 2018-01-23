FROM openjdk:9-jdk
MAINTAINER peter@pouliot.net

ENV GHE_VERSION 0.0.5
ENV JENKINS_VERSION 3.16
ENV JENKINS_CLI_VERSION 3.16

USER root
RUN \
    apt-get update -y \
    && apt-get install -y \
    git wget curl rsync ssh openssh-server vim \
    python python-dev screen \
    expect sudo ruby ruby-dev \
    rubygems gcc make byobu \
    bison dpkg-dev libgdbm-dev\
    bzip2 ca-certificates \
    libffi-dev libgdbm3 \
    libssl-dev libyaml-dev \
    procps zlib1g-dev

RUN wget https://bootstrap.pypa.io/get-pip.py && python ./get-pip.py
RUN pip install jenkins-job-builder jenkins-job-wrecker keyrings.alt Pygments && pip install https://git.generalassemb.ly/ga-admin-utils/ghe/releases/download/${GHE_VERSION}/ghe-${GHE_VERSION}.tar.gz
RUN gem install bundler 
RUN gem install github-pages jekyll rouge jekyll-redirect-from kramdown rdiscount 

RUN useradd -c "Jenkins Slave Service" jenkins -d  /home/jenkins -m -s /bin/bash
RUN useradd -c "GitHub Pages Editor" gh-pages -d  /home/gh-pages -m -s /bin/bash
RUN useradd -c "GitHub Backup Utils" gh-backup -d  /home/gh-backup -m -s /bin/bash

RUN echo -n "*** Installing Jenkins Slave and Client ***" \
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
    && cp ./backup-utils/backup.config-example ./backup.config

USER root
ENV HOME /
WORKDIR $HOME
COPY Dockerfile /Dockerfile
COPY ghe-startup.py /ghe-startup.py
COPY ghe-startup.sh /ghe-startup.sh
VOLUME /data
CMD /ghe-startup.sh
