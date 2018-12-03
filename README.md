# Docker-Valgrind
![Docker Build Status](https://img.shields.io/docker/build/avitase/docker-valgrind.svg)

The container exposes a leading edge version of `valgrind` and decent `cmake` and `g++` installations. The idea is to mount the root directory of your project to `/input` (read-only), compile it in the container to a temporary directory and show the logged output.
For example, consider the test project we provide in [test/](test/):
```
> tree test/
test/
├── CMakeLists.txt
└── test.cxx
```
The `WORKDIR` is set to `/home/valgrind/build`, such that one can safely compile this test project after mounting `-v "$SRC":/input:ro` , via `cmake /input/ && make`. Since `WORKDIR` is not part of a mounted volume, the result does not appear outside of the container. This workflow can conveniently be wrapped in a shell script, for instance as we did in [valgrind.sh](valgrind.sh).

## Docker Pull Command
The container is accessible via the [Docker Hub](https://hub.docker.com/r/avitase/docker-valgrind/): `docker pull avitase/docker-valgrind`.
You can create your own `Dockerfile` and install additional dependencies of your project via `apt-get`, for example:
```
FROM avitase/docker-valgrind:latest

USER root
apk add --update gtest

USER ${USERNAME}
```

