#!/bin/bash

#######################################################################################
# WARNING: This script only needs to be run once, after the first "docker compose up" #
#######################################################################################

PRIVATE_TOKEN=$1

sudo docker exec -t gitlab-ce gitlab-rails runner "token = User.find_by_username('root').personal_access_tokens.create(scopes: ['api'], name: 'register-runner-token', expires_at: 3.days.from_now); token.set_token('$PRIVATE_TOKEN'); token.save!"

RUNNER_TOKEN=$(curl -k --silent --request POST "https://gitlab.local:8443/api/v4/user/runners" \
    --header "private-token: $PRIVATE_TOKEN" \
    --data runner_type=instance_type --data 'description=Local docker runner' --data 'tag_list=local' \
  | jq -r '.token')

sudo docker exec -t gitlab-runner gitlab-runner register \
    --url "https://gitlab.local:8443" \
    --token "$RUNNER_TOKEN" \
    --non-interactive \
    --name=local-docker-runner \
    --executor=docker \
    --docker-tlsverify=false \
    --docker-privileged \
    --docker-image=docker:23.0.4 \
    --docker-volumes=/cache \
    --docker-network-mode=gitlab-network
