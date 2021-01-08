#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$BASH_SOURCE[0]")/../.." && pwd)"

echo "Docker Hub login..."
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
