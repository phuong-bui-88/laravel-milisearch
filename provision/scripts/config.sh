#!/bin/bash

source $(dirname $0)/include/init.sh
#echo $BASE_DIR
#echo $PORTAL_DIR
#echo $MAGELLAN_DIR
cp -rf $PORTAL_DIR/.env.example $PORTAL_DIR/.env

echo "APP_URL=http://portal.haegroup.com" >> $PORTAL_DIR/.env
sed -i -e 's/MYSQL_DB_HOST=localhost/MYSQL_DB_HOST=db/g' $PORTAL_DIR/.env
sed -i -e 's/MYSQL_DB_USERNAME=homestead/MYSQL_DB_USERNAME='$MYSQL_USER'/g' $PORTAL_DIR/.env
sed -i -e 's/MYSQL_DB_PASSWORD=secret/MYSQL_DB_PASSWORD='$MYSQL_PASSWORD'/g' $PORTAL_DIR/.env
sed -i -e 's/MYSQL_DB_HOST_WRITE=localhost/MYSQL_DB_HOST_WRITE=db/g' $PORTAL_DIR/.env
sed -i -e 's/PAYABLES/#PAYABLES/g' $PORTAL_DIR/.env
## config mail
sed -i -e 's/MAIL_DRIVER=log/MAIL_DRIVER=smtp/g' $PORTAL_DIR/.env
sed -i -e 's/MAIL_HOST=smtp.mailtrap.io/MAIL_HOST=mailhog/g' $PORTAL_DIR/.env
sed -i -e 's/MAIL_PORT=2525/MAIL_PORT=1025/g' $PORTAL_DIR/.env
## add mongodb
echo 'MONGODB_HOST=mongodb' >> $PORTAL_DIR/.env

## config magellan
sed -i -e 's/MAGELLAN_URL=http:\/\/localhost:8080\/magellan/MAGELLAN_URL=http:\/\/magellan:8080/g' $PORTAL_DIR/.env
## config redis
sed -i -e 's/REDIS_HOST=localhost/REDIS_HOST=redis/g' $PORTAL_DIR/.env

#
## generate key, migrate and run composer
source $BASE_DIR/scripts/config/magellan.sh
source $BASE_DIR/scripts/config/haebooking.sh
