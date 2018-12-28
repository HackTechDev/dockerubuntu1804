#!/bin/sh

docker run --hostname local \
    --rm \
    -v voluser:/home/voluser \
    -v "$(pwd)"/script:/script \
    -ti nekrofage/ubuntu1804test:latest \
    /bin/zsh
