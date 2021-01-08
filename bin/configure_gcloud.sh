#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$BASH_SOURCE[0]")/../.." && pwd)"

echo "Adding the Cloud SDK distribution URI as a package source..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

echo "Importing the Google Cloud Platform public key..."
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

echo "Updating the package list and installing the Cloud SDK..."
sudo apt-get update && sudo apt-get install google-cloud-sdk=$GCLOUD_SDK_VERSION

echo "Change owner and group for gcloud config dir..."
sudo chown -R circleci:circleci $HOME/.config/gcloud

echo "Decode credentials..."
echo $GCLOUD_SERVICE_KEY | base64 --decode -i > $CIRCLE_WORKING_DIRECTORY/cloud-credentials.json

echo "Authorize service account..."
gcloud auth activate-service-account --key-file $CIRCLE_WORKING_DIRECTORY/cloud-credentials.json

echo "Activate configurations..."
gcloud config configurations create $GCLOUD_CONFIGURATION_NAME --activate

echo "Configure account email..."
gcloud config set account $GCLOUD_SERVICE_EMAIL

echo "configure compute zone..."
gcloud config set compute/zone us-central1-b

echo "Configure core/project..."
gcloud config set core/project $GCLOUD_PROJECT

echo "Suppress prompts"
gcloud config set disable_prompts True

echo "Docker login..."
docker login -u _json_key --password-stdin https://us.gcr.io < $CIRCLE_WORKING_DIRECTORY/cloud-credentials.json
