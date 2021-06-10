#!/bin/bash
command=""
command=$command" php artisan key:generate;"
command=$command" npm install -D;"
command=$command" npm run production;"
command=$command" php artisan cache:clear;"
command=$command" php artisan migrate;"
command=$command" composer install;"
command=$command" php artisan db:seed --class=UserPermissions;"
command=$command" php artisan optimize;"

docker exec $COMPOSE_PROJECT_NAME'_'$CONNECT_DEFAULT_CONTAINER'_1' sh -c "$command"
