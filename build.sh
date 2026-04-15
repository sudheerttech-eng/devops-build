#!/bin/bash

set -e

DOCKER_USERNAME=sudheerttech
IMAGE_NAME=capstone
TAG=latest

echo "🔐 Logging into Docker Hub..."
docker login

echo "🏗️ Building Docker image..."
docker build -t $DOCKER_USERNAME/$IMAGE_NAME:$TAG .
