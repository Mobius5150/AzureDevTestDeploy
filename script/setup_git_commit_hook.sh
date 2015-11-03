#!/bin/bash

# This script configures the local git repo to automatically run jenkins tests after each commit.
# The post-commit hook will not cause the commit to fail if jenkins cannot be reached (if the container is not running)

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HOOK="${SCRIPTDIR}/../.git/hooks/post-commit"
JENKINS_DOCKER_INSTANCE="localhost:8081"
TEST_NAME="integration_test"
TEST_RUN_DELAY="0sec"

echo "curl http://${JENKINS_DOCKER_INSTANCE}/job/${TEST_NAME}/build?delay=${TEST_RUN_DELAY}" > $HOOK
chmod +x $HOOK
