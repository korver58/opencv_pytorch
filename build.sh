#!/bin/sh
docker build \
    --build-arg USER=developer \
    -t opencv_pytorch \
    -f Dockerfile . "$@"
