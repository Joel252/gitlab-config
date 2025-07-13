#!/bin/bash
set -euo pipefail

# Ensure jq is installed for JSON parsing
command -v jq > /dev/null 2>&1 || apk add --no-cache jq

# Check if GITLAB_URL and ADMIN_PAT are set
if [ -z "$GITLAB_URL" ] || [ -z "$ADMIN_PAT" ]; then
  echo "GITLAB_URL and ADMIN_PAT must be set in the environment."
  exit 1
fi

# Register runner and retrieve the token
TOKEN=$(curl -s -X POST "${GITLAB_URL}/api/v4/user/runners" \
  -H "PRIVATE-TOKEN: ${ADMIN_PAT}" \
  -d "runner_type=instance_type" \
  -d "description=shared-runner" \
  -d "tag_list=${TAGS}" \
  -d "run_untagged=${RUN_UNTAGGED}" | jq -r '.token')

if [ -z "$TOKEN" ]; then
  echo "Failed to retrieve runner token."
  exit 1
fi

# Register the GitLab Runner
gitlab-runner register \
  --non-interactive \
  --url "${GITLAB_URL}" \
  --token "${TOKEN}" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "shared-runner" \
  --tag-list "${TAGS}" \
  --run-untagged="${RUN_UNTAGGED}" \
  --locked="false" \
  --access-level="not_protected" \
  --docker-privileged \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

# Start the GitLab Runner service
gitlab-runner run || {
  echo "Failed to start GitLab Runner."
  exit 1
}