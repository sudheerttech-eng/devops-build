#!/bin/bash

set -e

DOCKER_USERNAME=sudheerttech
REPO=prod   # 🔥 IMPORTANT: Always private repo
TAG=latest
CONTAINER_NAME=capstone-app

echo "🔐 Logging into Docker Hub (required for private repo)..."
docker login

echo "📥 Pulling image from PRIVATE repo..."
docker pull $DOCKER_USERNAME/$REPO:$TAG

echo "🛑 Stopping old container..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

echo "🚀 Starting new container..."
docker run -d \
  -p 80:80 \
  --name $CONTAINER_NAME \
  $DOCKER_USERNAME/$REPO:$TAG

echo "✅ Deployment done from PRIVATE repo (prod)!"
