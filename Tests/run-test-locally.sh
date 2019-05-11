#!/bin/sh

# Run this script to check locally.

source PORT_HOST_TEST.env

NAME_HOST='localhost'
NAME_IMAGE='webapi-proxy:test'
DIR_CURRENT=$(cd $(dirname $0); pwd)
DIR_PARRENT=$(dirname $(cd $(dirname $0); pwd))

# Build image
cd $DIR_PARRENT
docker build --tag $NAME_IMAGE .
if [ $? -ne 0 ]; then
  echo 'Failed to build image'
  exit 1
fi

# Run tests
cd $DIR_CURRENT && \
docker-compose up -d --build && \
docker container ls | grep app1 && \
source run-test-container.sh && \
docker-compose down

# Remove image
cd $DIR_PARRENT
docker container prune -f && \
docker image prune -f && \
docker image rm NAME_IMAGE
