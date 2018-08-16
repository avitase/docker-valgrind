#!/bin/bash

IMAGE=avitase/docker-valgrind:latest
SRC=$PWD/test
CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Debug"
VALGRIND_ARGS="--leak-check=full --leak-resolution=med --track-origins=yes"
VALGRIND_LOG=valgrind.log
EXECUTABLE=a.out

exec docker run --rm -i --user="$(id -u):$(id -g)" \
-v "$SRC":/input:ro \
-v "$PWD":/output \
$IMAGE /bin/bash -c \
"cmake $CMAKE_ARGS /input/ && make && valgrind $VALGRIND_ARGS --log-file=/output/$VALGRIND_LOG ./$EXECUTABLE"
