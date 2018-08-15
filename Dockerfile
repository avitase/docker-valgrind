FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yqq && \
apt-get install -yqq apt-utils
RUN apt-get install -yqq build-essential valgrind
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /data
VOLUME ["/data"]
