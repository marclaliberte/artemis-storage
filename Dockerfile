FROM ubuntu:16.04
MAINTAINER Marc Laliberte
ENV DEBIAN_FRONTEND noninteractive
USER root

# Main packages
RUN apt-get update && \
  apt install -y --no-install-recommends \
    python \
    python-dev \ 
    mysql-client \
    libmysqlclient-dev \
    libev-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    curl \
    ca-certificates \
    vim \
    git 

RUN update-ca-certificates

# Install PIP
WORKDIR /tmp
RUN curl -sSL https://bootstrap.pypa.io/get-pip.py >> get-pip.py && \
  python get-pip.py && \
  pip install --upgrade setuptools

# PIP installs
RUN pip install -q cffi \
      hpfeeds \
      greenlet \
      gevent \
      MySQL-python \
      python-daemon \
      virustotal-api
RUN pip install -e git+https://github.com/rep/evnet.git#egg=evnet-dev

# Setup storage scripts
WORKDIR /opt
RUN git clone https://github.com/marclaliberte/artemis.git && \
  cd artemis && \
  cp config.cfg.default config.cfg && \
  sed -i "s/127\.0\.0\.1/mysql/g" /opt/artemis/config.cfg && \
  mkdir /var/artemis && \
  mkdir /var/artemis/files && \
  mkdir /var/artemis/files/attachment && \
  mkdir /var/artemis/files/inline && \
  mkdir /var/artemis/files/thug
  

WORKDIR /opt/artemis
ENTRYPOINT bash
