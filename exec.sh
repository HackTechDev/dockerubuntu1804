#!/bin/sh

docker run --hostname local \
    --rm \
    -e USER=util01 -e PASSWORD=mot2passe \
    -ti nekrofage/ubuntu1804test:latest \
    /bin/bash
