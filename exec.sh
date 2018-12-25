#!/bin/sh

docker run --hostname local \
    --rm \
    -ti nekrofage/ubuntu1804test:latest \
    /bin/zsh
