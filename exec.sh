#!/bin/sh

docker run --hostname local \
    --rm \
    -v volume01:/home/util01/volume01 \
    -ti nekrofage/ubuntu1804test:latest \
    /bin/zsh
