#!/bin/bash

################################################################################
#
# CENTRUM OS DOCKER-BASED ISO BUILDER
# Builds complete ISO using Alpine Linux build environment
# Works on any system with Docker installed
#
################################################################################

set -e

echo "═══════════════════════════════════════════════════════════════════"
echo "  CENTRUM OS - DOCKER-BASED ALPINE ISO BUILDER"
echo "═══════════════════════════════════════════════════════════════════"
echo ""

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${BUILD_DIR}/.." && pwd)"

echo "Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed"
    echo "Install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi

echo "Docker found. Building Centrum OS ISO inside Alpine container..."
echo ""

# Create Dockerfile for ISO build
cat > "${BUILD_DIR}/Dockerfile.iso" << 'DOCKERFILE'
FROM alpine:3.19

RUN apk add --no-cache \
    bash \
    curl \
    git \
    cdrkit \
    alpine-sdk \
    abuild \
    git \
    bash-completion

WORKDIR /build
COPY . .

RUN chmod +x build/build-complete-iso.sh
RUN bash build/build-complete-iso.sh

CMD ["sh"]
DOCKERFILE

echo "Building Docker image..."
docker build -f "${BUILD_DIR}/Dockerfile.iso" -t centrum-os-builder "${REPO_ROOT}"

echo ""
echo "Running builder in container..."
echo "Output will be in: build/output/"
echo ""

# Run builder
docker run --rm \
    -v "${REPO_ROOT}/build/output:/build/output" \
    centrum-os-builder \
    bash build/build-complete-iso.sh

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "Build complete! ISO is in: ${REPO_ROOT}/build/output/"
echo "═══════════════════════════════════════════════════════════════════"
