#!/bin/bash

################################################################################
#
# QUICK ISO BUILDER FOR CENTRUM OS
# Easy one-command builder for custom bootable OS
#
################################################################################

set -e

echo "Centrum OS - Custom Bootable OS Builder"
echo "========================================="
echo ""
echo "This script will build a complete bootable operating system"
echo "combining Alpine Linux core with Centrum OS."
echo ""

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check what's available
echo "Checking build options..."
echo ""

if command -v docker &> /dev/null; then
    echo "[1] Docker-based build (Recommended - works on any OS)"
    echo "[2] Direct build (Requires Alpine Linux tools)"
    echo ""
    read -p "Choose option (1-2): " CHOICE
    
    case $CHOICE in
        1)
            echo "Starting Docker-based build..."
            bash "${BUILD_DIR}/build-with-docker.sh"
            ;;
        2)
            echo "Starting direct build..."
            bash "${BUILD_DIR}/build-complete-iso.sh"
            ;;
        *)
            echo "Invalid choice"
            exit 1
            ;;
    esac
else
    echo "Docker not found. Using direct build..."
    bash "${BUILD_DIR}/build-complete-iso.sh"
fi

echo ""
echo "ISO is ready in: $(cd "${BUILD_DIR}/output" && pwd)/"
echo ""
echo "To boot the ISO:"
echo "  USB:  sudo dd if=centrum-os-*.iso of=/dev/sdX bs=4M"
echo "  QEMU: qemu-system-x86_64 -cdrom centrum-os-*.iso -m 2G"
echo "  VBox: Create VM > Attach ISO > Boot"
echo ""
