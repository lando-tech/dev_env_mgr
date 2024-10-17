#!/bin/bash

# Check if Docker Buildx is installed
if docker buildx version; then
    echo "Docker Buildx is already installed and configured"
else
    echo "Installing and configuring Docker Buildx..."
    # Create and switch to a new builder instance
    docker buildx create --name mybuilder
    docker buildx use mybuilder
    docker buildx inspect --bootstrap
fi

# Build the Docker image using Buildx
echo "Running Docker Buildx build..."
docker buildx build --tag dev_env:1.0 ../ --load

echo "Build complete" > buildx_docker_build.sh && chmod +x buildx_docker_build.sh
