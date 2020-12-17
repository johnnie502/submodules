#!/usr/bin/env bash

# Determines the UID of the user running the Docker containers.

if [ `uname` == 'Linux' ]; then
  # We're on Linux. There's no virtualization, so we use our own UID.
  export DOCKER_HOST_USER_ID="-e LOCAL_USER_ID=$(id -u)"
fi
