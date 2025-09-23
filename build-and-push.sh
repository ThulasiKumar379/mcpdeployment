#!/bin/bash
TAG=${1:-latest}
IMAGE="thulasikumar073/mcpserver:$TAG"

echo "[INFO] Building Docker image: $IMAGE"
docker build -t $IMAGE .

echo "[INFO] Logging into Docker Hub..."
docker login

echo "[INFO] Pushing image to Docker Hub..."
docker push $IMAGE

echo "[INFO] Done! Image available at: $IMAGE"

