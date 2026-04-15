#!/bin/bash

set -e

DOCKER_USERNAME=sudheerttech
IMAGE_NAME=capstone
TAG=latest

echo "🔐 Logging into Docker Hub..."
docker login

echo "🏗️ Building Docker image..."
docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$TAG .

# -------------------------------
# Push to DEV (Public)
# -------------------------------
echo "🏷️ Tagging for DEV repo..."
docker tag $DOCKER_USERNAME/$IMAGE_NAME:$TAG $DOCKER_USERNAME/dev:$TAG

echo "🚀 Pushing to DEV (public repo)..."
docker push $DOCKER_USERNAME/dev:$TAG

# -------------------------------
# Push to PROD (Private)
# -------------------------------
echo "🏷️ Tagging for PROD repo..."
docker tag $DOCKER_USERNAME/$IMAGE_NAME:$TAG $DOCKER_USERNAME/prod:$TAG

echo "🚀 Pushing to PROD (private repo)..."
docker push $DOCKER_USERNAME/prod:$TAG

echo "✅ Image pushed to BOTH dev & prod repos!"
