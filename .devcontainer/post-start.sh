#!/bin/bash

# Wait until Docker is fully available
echo "⏳ Waiting for Docker to be ready..."
until docker info >/dev/null 2>&1; do
    sleep 2
done

echo "✅ Docker is ready. Building image..."

# Build the Docker image
docker build -t qemu-virtualization .

# Run the Docker container
echo "🚀 Starting QEMU virtual environment..."
docker run -it --rm \
    --privileged \
    -v $(pwd)/os_images:/os-images \
    -p 6080:6080 -p 5901:5901 \
    qemu-virtualization
