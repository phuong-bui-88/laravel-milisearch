#!/bin/bash

source $(dirname $0)/include/init.sh

cd $BASE_DIR
echo "-----Remove the container-----"
docker-compose down
docker rm $(docker ps -aqf "name=^$COMPOSE_PROJECT_NAME")
echo "-----Building the container-----"
docker-compose build && docker-compose up
