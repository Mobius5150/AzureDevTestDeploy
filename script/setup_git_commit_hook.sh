#!/bin/bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HOOK="${SCRIPTDIR}/../.git/hooks/post-commit"
JENKINS_DOCKER_INSTANCE="localhost:8081"
TEST_NAME="integration_test"
TEST_RUN_DELAY="0sec"

echo "curl http://${JENKINS_DOCKER_INSTANCE}/job/${TEST_NAME}/build?delay=${TEST_RUN_DELAY}" > $HOOK
chmod +x $HOOK
