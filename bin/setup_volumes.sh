#!/usr/bin/env bash

set -eu

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd )"
. "$ROOT"/docker/lib/setup_nfs_functions.sh
. "$ROOT"/docker/lib/volumes.sh

if [[ "$(uname)" == 'Darwin' ]]; then
  # On mac, setup NFS server and create NFS volumes
  TYPE='nfs'
  OPTS='addr=host.docker.internal,rw,nolock,hard,nointr,nfsvers=3'
  # Check if NFS exports already exists
  if showmount -e | grep -qF '/System/Volumes/Data'; then
    echo "NFS exports ready"
  else
    echo "Setting up the NFS server, your password will be required..."

    # Allow connections from any port
    writeToFile 'Allow connections from any port' 'nfs.server.mount.require_resv_port = 0' '/etc/nfs.conf'

    # Config file system exports on macOS Catalina
    uid=${UID:-"$(id -u "$(whoami)")"}
    gid=${GID:-"$(id -g "$(whoami)")"}
    writeToFile 'Export file system' "/System/Volumes/Data -alldirs -mapall=${uid}:${gid} localhost" '/etc/exports'

    echo " - Restarting the NFS server"
    sudo nfsd restart

    echo "NFS exports ready"
  fi
else
  # On linux, create local bind volumes
  TYPE='none'
  OPTS='bind'
fi

# Loop over each of the volumes
for VOLUME in "${!VOLUMES[@]}"; do
  # And check if it exists
  if ! docker volume ls | grep -qF "${VOLUME}"; then
    # If not, then create it
    createDockerVolume "${VOLUME}" "${VOLUMES[$VOLUME]}" "${TYPE}" "${OPTS}"
  else
    recreateVolumeIfMountFromDifferentFolder "${VOLUME}" "${VOLUMES[$VOLUME]}" "${TYPE}" "${OPTS}"
  fi
done
