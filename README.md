# Docker-Valgrind
![Docker Build Status](https://img.shields.io/docker/build/avitase/docker-valgrind.svg) ![Image Size](https://img.shields.io/microbadger/image-size/avitase/docker-valgrind.svg)

The container exposes a decent `valgrind`, `cmake` and `g++` installation. The idea is to mount the root directory of your project to `/input` (read-only) and compile it in the container to a temporary directory. From here on one can run Valgrind and write the output to `/output`.
For example, consider the test project we provide in [test/](test/):
```
> tree test/
test/
├── CMakeLists.txt
└── test.cxx
```
The `WORKDIR` is set to `/home/valgrind/build`, such that one can safely compile this test project, after mounting `-v "$SRC":/input:ro` and `-v "$PWD":/output`, via `cmake /input/ && make`. Since `WORKDIR` is not part of a mounted volume, the result does not appear outside of the container. One can now run Valgrind and store the log file in `/output`, i.e:
```
valgrind --log-file=/output/valgrind.log ./a.out
```
This workflow can conveniently be wrapped in a shell script, for instance as we did here: [valgrind.sh](valgrind.sh)

## Docker Pull Command
The container is accessible via the Docker Hub: `docker pull avitase/docker-valgrind`.
You can create your own `Dockerfile` and install additional dependencies of your project via `apt-get`, for example:
```
FROM avitase/docker-valgrind:latest

USER root
RUN apt-get update -yqq && \
apt-get install -yqq libgtest-dev && \
cd /usr/src/gtest && \
cmake -Dgtest_disable_pthreads=ON && \
make && \
cp *.a /usr/lib

USER ${USERNAME}
```

