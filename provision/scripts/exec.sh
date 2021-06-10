#!/bin/bash
BASE_DIR=`cd $(dirname "$0")/..; pwd`
source ${BASE_DIR}/.env
if [ "x${1}" == "x" ]
then
  echo "Please input command!"
  exit
fi
cd $BASE_DIR
SERVICE_LIST=`docker-compose ps --services`
# Get bash type
M_OS=`uname | tr '[:upper:]' '[:lower:]'`
CONNECT_CONTAINER=$CONNECT_DEFAULT_CONTAINER
if [ "x${1}" = "xi" ]
then
  shift
  if [ "x${1}" != "x" ]
  then
    CONNECT_CONTAINER=$1
  fi
  if [ "x${CONNECT_CONTAINER}" = "x" ]
  then
    echo "Please set service for interacting!"
    exit
  fi
  if [ "x${COMPOSE_PROJECT_NAME}" != "x" ]
  then
    if ! [[ $CONNECT_CONTAINER =~ ^${COMPOSE_PROJECT_NAME}_ ]]
    then
      CONNECT_CONTAINER=${COMPOSE_PROJECT_NAME}_${CONNECT_CONTAINER}
    fi
  fi
  if ! [[ ${CONNECT_CONTAINER} =~ _[0-9]*$ ]]
  then
    CONNECT_CONTAINER=${CONNECT_CONTAINER}_1
  fi
  if [ "x${M_OS:0:5}" = "xmingw" ]
  then
    winpty docker exec -it ${CONNECT_CONTAINER} bash
  else
    docker exec -it ${CONNECT_CONTAINER} bash
  fi
  exit
fi
function dobash() {
  if [ "x${1}" = "x" ]
  then
    if [ "x${CONNECT_CONTAINER}" = "x" ]
    then
      echo "Please set container for running!"
      exit
    fi
    echo "Please set command for running!"
    exit
  fi
  while IFS= read -r line; do
    line=`echo $line`
    if [ "x${1}" = "x${line}" ]
    then
      CONNECT_CONTAINER=$1
      shift
      break
    fi
  done <<< "$SERVICE_LIST"
  if [ "x${CONNECT_CONTAINER}" = "x" ]
  then
    echo "Please set container for running!"
    exit
  fi
  if [ "x${1}" = "x" ]
  then
    echo "Please set command for running!"
    exit
  fi
  if [ "x${COMPOSE_PROJECT_NAME}" != "x" ]
  then
    if ! [[ $CONNECT_CONTAINER =~ ^${COMPOSE_PROJECT_NAME}_ ]]
    then
      CONNECT_CONTAINER=${COMPOSE_PROJECT_NAME}_${CONNECT_CONTAINER}
    fi
  fi
  if ! [[ ${CONNECT_CONTAINER} =~ _[0-9]*$ ]]
  then
    CONNECT_CONTAINER=${CONNECT_CONTAINER}_1
  fi
  docker exec "${CONNECT_CONTAINER}" bash -c "$*"
}
if [ "x${1}" = "xa" ]
then
  shift
  dobash $CONNECT_DEFAULT_CONTAINER php artisan --ansi "$@"
else
  dobash "$@"
fi
