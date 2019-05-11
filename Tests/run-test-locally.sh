#!/bin/sh

# Run this script to check locally.

cd $(dirname $0)

source PORT_HOST_TEST.env

NAME_HOST='localhost'

docker-compose up -d && \
docker container ls | grep app1 && \
source run-test-container.sh && \
docker-compose down
