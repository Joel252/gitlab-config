#!/bin/bash
gitlab-runner register \
  --non-interactive \
  --url "https://${GITLAB_DOMAIN}/" \
  --registration-token "${GITLAB_RUNNER_TOKEN}" \
  --executor "docker" \
  --docker-image alpine:latest \
  --description "Docker GitLab Runner" \
  --tag-list "docker,ci" \
  --run-untagged="true" \
  --locked="false" \
  --access-level="not_protected"

gitlab-runner run
