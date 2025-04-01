#!/bin/bash
gitlab-runner register \
  --non-interactive \
  --url "${GITLAB_EXTERNAL_URL}" \
  --registration-token "${GITLAB_RUNNER_TOKEN}" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "Docker GitLab Runner" \
  --tag-list "docker,ci" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected" \
  --docker-privileged \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

gitlab-runner run
