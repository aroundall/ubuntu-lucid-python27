FROM ubuntu:lucid
MAINTAINER Roy Yang "aroundall@gmail.com"

RUN mkdir -p /root/env
WORKDIR /root/env

RUN sed -i -e "s/archive.ubuntu.com/old-releases.ubuntu.com/g" /etc/apt/sources.list
RUN echo "deb http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu lucid main" >> /etc/apt/sources.list
RUN echo "deb-src http://ppa.launchpad.net/fkrull/deadsnakes/ubuntu lucid main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DB82666C
RUN apt-get update && apt-get install -y \
    python2.7 \
    python2.7-dev \
    wget \
    libxml2-dev \
    libxslt-dev \
&& rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate https://pypi.python.org/packages/source/d/distribute/distribute-0.6.49.tar.gz
RUN tar -xzvf distribute-0.6.49.tar.gz
RUN cd distribute-0.6.49 && python2.7 setup.py install && cd ..

RUN mkdir -p /root/src
WORKDIR /root/src

RUN rm -r /root/env