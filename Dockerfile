FROM ubuntu:latest

ARG USERNAME=valgrind

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

RUN apt-get update -yqq && \
apt-get install -yqq \
apt-utils ca-certificates

RUN apt-get install -yqq locales && locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get install -yqq \
build-essential cmake valgrind
ENV CC /usr/bin/gcc
ENV CXX /usr/bin/g++

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /output && \
mkdir -p /input && \
chmod -R a+rwX /output/ && \
chmod -R a+rwX /input/

RUN useradd -ms /bin/bash ${USERNAME}
USER ${USERNAME}
RUN mkdir -p /home/${USERNAME}/build
WORKDIR /home/${USERNAME}/build

VOLUME ["/input", "/output"]
