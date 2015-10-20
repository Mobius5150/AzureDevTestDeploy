###########################################
# Build and run the ci client application
#
# If docker-machine is present assume that
# docker-machine is managing the docker
# hosts and us that. Otherwise use the same
# machine that this script is running on.
###########################################

source script/config.sh

echo "Staging ci client application version $WEB_STAGE_VERSION on $STAGE_MACHINE_NAME"
eval "$(docker-machine env $STAGE_MACHINE_NAME)"
docker info

cd ci

# Build the container to ensure we pick up any changes
docker build -t ci:$WEB_STAGE_VERSION .

# Stop, remove and restart the container
echo "Stopping any running (staged) web ci application containers"
docker stop stage_ci
echo "Removing any previously (staged) web ci application containers"
docker rm stage_ci
echo "Running web ci app containers"
docker run -t -d --name=stage_ci1 ci:$WEB_STAGE_VERSION

cd ..
