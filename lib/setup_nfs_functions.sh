#!/usr/bin/env bash

set -eu

#######################################
# Write a line to a file using sudo
#
# Arguments:
#   1 message to output
#   2 the line to write
#   3 the file path
#######################################
writeToFile() {
  local message=$1
  local line=$2
  local file=$3

  if ! grep -qF -- "$line" "$file"; then
    echo " - ${message}"
    echo "$line" | sudo tee -a "$file" > /dev/null
  else
    echo " - ${message} already exists on ${file}, skipping..."
  fi
}

#######################################
# Creates a Docker volume
#
# Arguments:
#   1 the volume name
#   2 the volume path
#   3 the volume type
#   4 the volume opts
#######################################
createDockerVolume() {
  local VOLUME_NAME=$1
  local VOLUME_PATH=$2
  local VOLUME_TYPE=$3
  local VOLUME_OPTS=$4

  echo "Creating Docker Volume ${VOLUME_NAME} for path ${VOLUME_PATH}"

  if [[ ! -e ${VOLUME_PATH} ]]; then
    echo "${VOLUME_PATH} doesn't exist, creating the directory..." 1>&2
    mkdir ${VOLUME_PATH}
  elif [[ ! -d ${VOLUME_PATH} ]]; then
    echo "${VOLUME_PATH} already exists but is not a directory" 1>&2
  fi

  if [[ $VOLUME_TYPE = 'nfs' ]]; then
    VOLUME_PATH=":${VOLUME_PATH}"
  fi

  docker volume create \
    --driver local \
    --opt type="${VOLUME_TYPE}" \
    --opt o="${VOLUME_OPTS}" \
    --opt device="${VOLUME_PATH}" \
    "${VOLUME_NAME}" > /dev/null
}

#######################################
# Recreate a Docker volume if the existing volume is mounted from incorrect location.
#
# Arguments:
#   1 the volume name
#   2 the volume path
#   3 the volume type
#   4 the volume opts
#######################################
recreateVolumeIfMountFromDifferentFolder() {
  local VOLUME_NAME=$1
  local VOLUME_PATH=$2
  local VOLUME_TYPE=$3
  local VOLUME_OPTS=$4
  if [[ $(docker volume inspect --format '{{.Options.device}}' ${VOLUME_NAME}) != ":${VOLUME_PATH}" ]]; then
    docker volume rm "${VOLUME_NAME}"
    createDockerVolume "${VOLUME_NAME}" "${VOLUME_PATH}" "${VOLUME_TYPE}" "${VOLUME_OPTS}"
  fi
}
