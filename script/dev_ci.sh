###########################################
# Build and run the ci application.
#
# If docker-machine is present assume that
# docker-machine is managing the docker
# hosts and us that. Otherwise use the same
# machine that this script is running on.
###########################################

source script/config.sh

eval "$(docker-machine env $DEV_MACHINE_NAME)"
docker-machine env $DEV_MACHINE_NAME

cd ci

# Build the container to ensure we pick up any changes
docker build -t ci:latest .

# Stop, remove and restart the container
echo "Stopping any running dev container for ci app"
docker stop dev_ci
echo "Removing any previous dev container ci app"
docker rm dev_ci
echo "Running a ci app dev container"
docker run -d -v $(pwd)/www/:/var/www -p $DEV_WEBCIAPP_PORT:80 --name=dev_ci ci:latest

cd ..
