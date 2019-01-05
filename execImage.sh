#!/bin/sh

docker run --hostname local \
    --rm \
    -v voluser:/home/voluser \
    -v "$(pwd)"/script:/script \
    -v "$(pwd)"/system:/system \
    -ti nekrofage/ubuntu1804server:latest \
    /bin/zsh -c "cp /system/etc/passwd /etc/; cp /system/etc/shadow /etc/; /bin/zsh"
