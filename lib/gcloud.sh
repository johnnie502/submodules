#!/usr/bin/env bash

set -eu

######################################################
# Delete old versions of service on Google App Engine.
#
# Arguments:
#   1 the name of the service on GAE
#   2 the maximum number of versions to keep on GAE
######################################################
delete_old_versions() {
  local service=$1
  local max_service_versions=$2
  local versions=0
  local ids=0

  echo ""
  echo "Checking number of versions for $service service"
  versions=$(gcloud app versions list --service="$service" --format="table[no-heading](version.id)" | wc -l)

  if [ "$versions" -le "$max_service_versions" ]; then
    echo "No old versions to delete"
    return 0;
  fi

  echo "Deleting $((versions - max_service_versions)) old versions"

  ids=$(gcloud app versions list \
    --service="$service" \
    --filter="version.servingStatus=stopped" \
    --limit=$((versions - max_service_versions)) \
    --format="table[no-heading](version.id)")

  for version in $ids
  do
    yes | gcloud app versions delete --service="$service" "$version"
  done
}
