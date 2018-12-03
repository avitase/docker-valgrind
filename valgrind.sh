#!/bin/bash

if [ $# -eq 0 ]; then
    VALGRIND_ARGS="--leak-check=full --leak-resolution=med --track-origins=yes"
else
    VALGRIND_ARGS="$1"
fi
echo Running valgrind with: $VALGRIND_ARGS

IMAGE=avitase/docker-valgrind:latest
SRC=$PWD/test
CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Debug"
VALGRIND_ARGS="--leak-check=full --leak-resolution=med --track-origins=yes"
EXECUTABLE=a.out

exec docker run --rm -i \
-v "$SRC":/input:ro \
$IMAGE /bin/sh -c \
"cmake $CMAKE_ARGS /input/ && make && valgrind $VALGRIND_ARGS ./$EXECUTABLE"
