#!/bin/bash

BASE_DIR=`cd $(dirname "$0")/..; pwd`
source ${BASE_DIR}/.env

if [ "x${1}" = "x" ]
then
  echo "Please input the first parameter as database name which you want to grant privileges for user <${MYSQL_USER}>."

  exit
fi

docker exec ${COMPOSE_PROJECT_NAME}_db_1 sh -c "/usr/bin/mysql -p$MYSQL_ROOT_PASSWORD -e \
  'CREATE DATABASE IF NOT EXISTS "'`'${1}'`'";
    GRANT ALL PRIVILEGES ON "'`'${1}'`'".* TO \"${MYSQL_USER}\"@\"%\"; FLUSH PRIVILEGES;'"
