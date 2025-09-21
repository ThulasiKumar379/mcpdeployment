#!/bin/bash
set -e

# === Variables ===
IMAGE_NAME="mcpserver"
DOCKER_USER="thulasikumar073"
TAG=${1:-latest}   # Default tag is 'latest' if not provided
FULL_IMAGE="$DOCKER_USER/$IMAGE_NAME:$TAG"

# === Build Docker image ===
echo "[INFO] Building Docker image: $FULL_IMAGE"
docker build -t "$FULL_IMAGE" .

# === Login to Docker Hub ===
echo "[INFO] Logging into Docker Hub..."
docker login -u "$DOCKER_USER"

# === Push to Docker Hub ===
echo "[INFO] Pushing image to Docker Hub..."
docker push "$FULL_IMAGE"

echo "[INFO] Done! Image available at: docker.io/$FULL_IMAGE"
