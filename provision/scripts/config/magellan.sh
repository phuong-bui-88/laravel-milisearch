#!/bin/bash
JETTY_DIR=$MAGELLAN_DIR/src/main/webapp/WEB-INF
sed -i -e 's/localhost/db/g' $JETTY_DIR/jetty-web.xml
sed -i -e 's/"user">portal/"user">'$MYSQL_USER'/g' $JETTY_DIR/jetty-web.xml
sed -i -e 's/"password">Carr377i/"password">'$MYSQL_PASSWORD'/g' $JETTY_DIR/jetty-web.xml
#
# update password into database.java
DATABASE_DIR=$MAGELLAN_DIR/src/main/java/com/haegroup/data
sed -i -e 's/String username = "root"/String username = "'$MYSQL_USER'"/g' $DATABASE_DIR/Database.java
sed -i -e 's/String password = ""/String password = "'$MYSQL_PASSWORD'"/g' $DATABASE_DIR/Database.java
sed -i -e 's/localhost/db/g' $DATABASE_DIR/Database.java
