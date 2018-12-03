FROM alpine:latest

ARG USERNAME=user

RUN apk add --update g++ make cmake valgrind
ENV CC /usr/bin/gcc
ENV CXX /usr/bin/g++

RUN \
mkdir -p /output && \
mkdir -p /input && \
chmod -R a+rwX /output/ && \
chmod -R a+rwX /input/

RUN adduser -SD ${USERNAME}
USER ${USERNAME}

RUN mkdir -p /home/${USERNAME}/build
WORKDIR /home/${USERNAME}/build

VOLUME ["/input", "/output"]
