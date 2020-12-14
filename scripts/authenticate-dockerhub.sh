#!/bin/bash


read -p "Docker userid: " userid
read -p "Docker email: " usermail
read -sp "Docker password: " userpass

kubectl create secret docker-registry dockerhub \
  --docker-username=$userid \
  --docker-password=$usermail \
  --docker-email=$userpass


kubectl patch serviceaccount default \
  -p "{\"imagePullSecrets\": [{\"name\": \"dockerhub\"}]}"

echo Configured secret for $userid