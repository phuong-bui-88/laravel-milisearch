##Require:
- Windows 10 Pro
- Git on windows
##Init:
- Clone the source code
- Download database and rename them to .data
##Run
- Copy environment from `./provision/.env.example` to `./provision/.env`
- `cd ./script` , move to the script folder
- `./build.sh` , run build.sh
- `./config.sh`, set up the config environment
##Xdebug
You can follow [at here](https://slides.com/ocditimban/deck-d0a822#/) 
## Userful
- `./provision/scripts/exec.sh php -v` => run command line in container
- `./provision/scripts/exec.sh a [arguments]` => shortcut to php artisan [arguments]
- `./provision/scripts/exec.sh i fpm` => exec container
# Port
- Mail: http://localhost:8025/
- Database: http://localhost:99/
- App: http://localhost:90/
- Magellan: http://localhost:65/


# Install magellan
 - Run docker-compose up
 - Run ./script/rebuild.sh
 

