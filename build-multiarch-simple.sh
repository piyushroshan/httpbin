#!/bin/bash

# Simple multiarch build script for httpbin
set -e
set -x

IMAGE_NAME="allvulnapps/httpbin"
VERSION="0.9.2"
PLATFORMS="linux/amd64,linux/arm64"

echo "Setting up buildx driver for multiarch builds..."

# Create and use a new builder instance that supports multiarch
docker buildx create --name multiarch-builder --driver docker-container --use 2>/dev/null || docker buildx use multiarch-builder

echo "Building multiarch image for httpbin..."

# Build and push for multiple architectures in one go
docker buildx build \
  --platform $PLATFORMS \
  --tag $IMAGE_NAME:$VERSION \
  --tag $IMAGE_NAME:latest \
  --push \
  .

echo "Multiarch build completed!"
echo "Image: $IMAGE_NAME:$VERSION"
echo "Platforms: $PLATFORMS"

# Show the manifest
echo ""
echo "Manifest information:"
docker buildx imagetools inspect $IMAGE_NAME:$VERSION
