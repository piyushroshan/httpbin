#!/bin/bash

# Setup script for Docker Buildx multiarch support
set -e

echo "Setting up Docker Buildx for multiarch builds..."

# Check if buildx is available
if ! docker buildx version >/dev/null 2>&1; then
    echo "Error: Docker Buildx is not available. Please install Docker Desktop or update Docker."
    exit 1
fi

# Create a new builder instance for multiarch builds (or use existing)
echo "Setting up multiarch builder instance..."
docker buildx create --name multiarch-builder --driver docker-container --use 2>/dev/null || docker buildx use multiarch-builder

# Inspect the builder to confirm it's set up correctly
echo "Builder setup complete. Current builder:"
docker buildx inspect

echo ""
echo "Multiarch builder is ready!"
echo "You can now run: ./build-multiarch-simple.sh"
