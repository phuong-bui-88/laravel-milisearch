#!/bin/bash

BASE_DIR=`cd $(dirname "$0")/../..; pwd`
source ${BASE_DIR}/.env

docker exec ${COMPOSE_PROJECT_NAME}_db_1 sh -c "/usr/bin/mysql -p$MYSQL_ROOT_PASSWORD $MYSQL_BOOKING_DATABASE -e \

  'UPDATE sites SET "'`'hos_address'`'"=\"db-hos\", "'`'hos_database_user'`'"=\"root\",\
                    "'`'hos_database_password'`'"=\"${MYSQL_ROOT_PASSWORD}\";\
  UPDATE ${MYSQL_DATABASE}.portals SET domain_name=\"alg.haebooking.lc\" WHERE template_name=\"alg\";'"
