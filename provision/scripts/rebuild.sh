# rebuild war file of magellan
docker restart portal_maven_1
winpty docker exec portal_maven_1 sh -c "mvn install && mvn compile"
docker restart portal_magellan_1
