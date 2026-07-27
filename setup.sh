#!/bin/bash

################################################################################
#
# DOWNLOAD AND RUN CENTRUM OS
# One-command setup for downloading and running Centrum OS
#
################################################################################

set -e

echo "Centrum OS - One-Command Setup"
echo "================================"
echo ""

# Detect OS
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    ARCH=$(uname -m)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    ARCH=$(uname -m)
else
    OS="unknown"
fi

echo "Detected: $OS $ARCH"
echo ""

# Check available installation methods
echo "Installation options:"
echo ""

if [[ "$OS" == "linux" ]]; then
    echo "[1] Install locally (current user)"
    echo "[2] Install system-wide (requires sudo)"
    echo "[3] Run in Docker"
    echo "[4] Build bootable ISO"
    echo ""
    read -p "Choose option (1-4): " METHOD
    
    case $METHOD in
        1)
            echo "Installing for current user..."
            bash install.sh
            echo ""
            echo "Add to PATH:"
            echo "  export PATH=\"$HOME/.local/bin:\$PATH\""
            echo ""
            echo "Then start with:"
            echo "  centrum greet"
            ;;
        2)
            echo "Installing system-wide..."
            sudo bash install.sh --system
            echo "Installed! Run: centrum greet"
            ;;
        3)
            echo "Building Docker image..."
            docker build -t centrum-os .
            echo "Running container..."
            docker run -it centrum-os
            ;;
        4)
            echo "Building ISO..."
            bash build/quick-build.sh
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
else
    echo "Your OS: $OS"
    echo "Recommended: Docker installation"
    docker build -t centrum-os .
    docker run -it centrum-os
fi

echo ""
echo "Setup complete!"
