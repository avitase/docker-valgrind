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
build-essential automake autoconf cmake 
ENV CC /usr/bin/gcc
ENV CXX /usr/bin/g++

RUN mkdir -p /output && \
mkdir -p /input && \
chmod -R a+rwX /output/ && \
chmod -R a+rwX /input/

RUN useradd -ms /bin/bash ${USERNAME}
COPY valgrind /home/${USERNAME}/valgrind-src
RUN chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/valgrind-src

USER ${USERNAME}
RUN mkdir -p /home/${USERNAME}/valgrind && \
cd /home/${USERNAME}/valgrind-src && \
./autogen.sh && \
./configure --prefix=/home/${USERNAME}/valgrind && \
make && \
make install
ENV PATH="/home/${USERNAME}/valgrind/bin:${PATH}"
ENV LD_LIBRARY_PATH="/home/${USERNAME}/valgrind/lib:${LD_LIBRARY_PATH}"

USER root
RUN apt-get purge -yqq \
automake autoconf && \
rm -rf /home/${USERNAME}/valgrind-src
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
USER ${USERNAME}

RUN mkdir -p /home/${USERNAME}/build
WORKDIR /home/${USERNAME}/build

VOLUME ["/input", "/output"]
