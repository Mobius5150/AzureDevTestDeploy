###########################################
# Build and run the web "CI" application.
#
# If docker-machine is present assume that
# docker-machine is managing the docker
# hosts and us that. Otherwise use the same
# machine that this script is running on.
###########################################

source script/config.sh

eval "$(docker-machine env $DEV_MACHINE_NAME)"
docker-machine env $DEV_MACHINE_NAME

cd web_ci

# Build the container to ensure we pick up any changes
docker build -t web_ci:latest .

# Stop, remove and restart the container
echo "Stopping any running dev container for web ci app"
docker stop dev_web_ci
echo "Removing any previous dev container web ci app"
docker rm dev_web_ci
echo "Running a web ci app dev container"
docker run -d -v $(pwd)/www/:/var/www -p $DEV_WEBCIAPP_PORT:80 --name=dev_web_ci web_ci:latest

cd ..
