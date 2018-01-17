FROM openjdk:9-jdk
MAINTAINER peter@pouliot.net

ENV GHE_VERSION 0.0.5
ENV JENKINS_VERSION 3.16
ENV JENKINS_CLI_VERSION 3.16

USER root
RUN apt-get update -y && apt-get install -y git wget curl rsync ssh python screen expect sudo ruby rubygems gcc make byobu
RUN git clone -b stable https://github.com/github/backup-utils
RUN cp ./backup-utils/backup.config-example ./backup.config
RUN wget https://bootstrap.pypa.io/get-pip.py && python ./get-pip.py
RUN pip install keyrings.alt && pip install https://git.generalassemb.ly/ga-admin-utils/ghe/releases/download/${GHE_VERSION}/ghe-${GHE_VERSION}.tar.gz
RUN gem install jekyll pygments rouge github-pages
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_VERSION}/remoting-${JENKINS_VERSION}.jar \
  && curl --create-dirs -sSLo /usr/share/jenkins/cli.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/cli/${JENKINS_CLI_VERSION}/cli-${JENKINS_CLI_VERSION}-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar \
  && chmod 644 /usr/share/jenkins/cli.jar
COPY Dockerfile /Dockerfile
VOLUME /data
