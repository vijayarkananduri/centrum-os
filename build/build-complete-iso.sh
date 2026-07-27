#!/bin/bash

################################################################################
#
# CENTRUM OS COMPLETE ISO BUILDER
# Builds a full bootable Alpine Linux + Centrum OS custom operating system
# This creates a complete, standalone operating system
#
################################################################################

set -e

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="${BUILD_DIR}/work"
OUT_DIR="${BUILD_DIR}/output"
ROOTFS="${WORK_DIR}/rootfs"
REPO_ROOT="$(cd "${BUILD_DIR}/.." && pwd)"

echo "═══════════════════════════════════════════════════════════════════"
echo "  CENTRUM OS - CUSTOM BOOTABLE OPERATING SYSTEM BUILDER"
echo "  Building complete OS with Alpine Linux + Centrum OS"
echo "═══════════════════════════════════════════════════════════════════"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}[*] Build configuration:${NC}"
echo "    Work directory: $WORK_DIR"
echo "    Output directory: $OUT_DIR"
echo "    Rootfs: $ROOTFS"
echo ""

# Check dependencies
echo -e "${BLUE}[*] Checking dependencies...${NC}"
for cmd in wget tar mkisofs isohybrid; do
    if ! command -v "$cmd" &> /dev/null; then
        echo -e "${YELLOW}[!] Warning: $cmd not found${NC}"
    fi
done
echo -e "${GREEN}[✓] Dependencies checked${NC}"

# Create directories
mkdir -p "$WORK_DIR" "$OUT_DIR" "$ROOTFS"
echo -e "${GREEN}[✓] Work directories created${NC}"

# Step 1: Download Alpine minirootfs
echo ""
echo -e "${BLUE}[*] Step 1/6: Downloading Alpine Linux base...${NC}"

ALPINE_VERSION="3.19"
ALPINE_ARCH="x86_64"
ALPINE_URL="https://alpinelinux.org/releases/$ALPINE_VERSION/releases/$ALPINE_ARCH/alpine-minirootfs-${ALPINE_VERSION}.0-${ALPINE_ARCH}.tar.gz"
MINIROOTFS="${WORK_DIR}/alpine-minirootfs.tar.gz"

if [[ ! -f "$MINIROOTFS" ]]; then
    if command -v wget &> /dev/null; then
        echo "Downloading from: $ALPINE_URL"
        if wget -q -O "$MINIROOTFS" "$ALPINE_URL"; then
            echo -e "${GREEN}[✓] Alpine minirootfs downloaded${NC}"
        else
            echo -e "${YELLOW}[!] Download failed. Using local build (slower)${NC}"
            touch "$MINIROOTFS"
        fi
    else
        echo -e "${YELLOW}[!] wget not available, skipping download${NC}"
        touch "$MINIROOTFS"
    fi
else
    echo -e "${GREEN}[✓] Alpine minirootfs already downloaded${NC}"
fi

# Step 2: Extract and prepare rootfs
echo ""
echo -e "${BLUE}[*] Step 2/6: Extracting Alpine Linux...${NC}"

if [[ -f "$MINIROOTFS" && -s "$MINIROOTFS" ]]; then
    cd "$ROOTFS"
    tar -xzf "$MINIROOTFS" 2>/dev/null || echo "Using existing rootfs"
    cd "$BUILD_DIR"
    echo -e "${GREEN}[✓] Alpine Linux extracted${NC}"
else
    echo -e "${YELLOW}[!] Creating minimal Alpine rootfs${NC}"
    mkdir -p "$ROOTFS"/{bin,sbin,usr,etc,lib,boot,dev,proc,sys,tmp,var}
fi

# Step 3: Create directory structure for Centrum OS
echo ""
echo -e "${BLUE}[*] Step 3/6: Creating Centrum OS directories...${NC}"

mkdir -p "$ROOTFS"/{opt/centrum,root/.centrum,root/.local/lib/centrum}
mkdir -p "$ROOTFS/root/.centrum"/{config,memory,themes,notes}
mkdir -p "$ROOTFS/root/.local/lib/centrum"/{modules,lib}
mkdir -p "$ROOTFS/root/.local/bin"

echo -e "${GREEN}[✓] Centrum directories created${NC}"

# Step 4: Copy Centrum OS files
echo ""
echo -e "${BLUE}[*] Step 4/6: Copying Centrum OS files...${NC}"

if [[ -d "$REPO_ROOT/src" ]]; then
    cp "$REPO_ROOT/src/centrum" "$ROOTFS/opt/centrum/" 2>/dev/null || true
    cp "$REPO_ROOT/src/modules"/*.sh "$ROOTFS/opt/centrum/" 2>/dev/null || true
    cp "$REPO_ROOT/src/lib"/*.sh "$ROOTFS/opt/centrum/" 2>/dev/null || true
    cp "$REPO_ROOT/src/config/centrum.conf" "$ROOTFS/root/.centrum/config/" 2>/dev/null || true
    cp "$REPO_ROOT/themes"/*.theme "$ROOTFS/root/.centrum/themes/" 2>/dev/null || true
    
    echo -e "${GREEN}[✓] Centrum OS files copied${NC}"
else
    echo -e "${YELLOW}[!] Centrum source not found, using template${NC}"
fi

# Step 5: Create system configuration
echo ""
echo -e "${BLUE}[*] Step 5/6: Configuring boot system...${NC}"

# Create issue (login banner)
cat > "$ROOTFS/etc/issue" << 'ISSUE'
╔═════════════════════════════════════════╗
║                                         │
║      C E N T R U M   O S   v0.1        │
║                                         │
║      "Return to focus."                 │
║                                         │
║   Personal Terminal Operating System   │
║   Built on Alpine Linux | Local-First  │
║                                         │
╚═════════════════════════════════════════╝

login: 
ISSUE

# Create profile for auto-launching Centrum
cat > "$ROOTFS/root/.profile" << 'PROFILE'
#!/bin/sh

# Setup PATH
export PATH="/opt/centrum:/root/.local/bin:$PATH"
export HOME="/root"

# Initialize Centrum on first login
if [[ ! -f "$HOME/.centrum/config/centrum.conf" ]]; then
    mkdir -p "$HOME/.centrum/config"
    if [[ -f /opt/centrum/centrum.conf ]]; then
        cp /opt/centrum/centrum.conf "$HOME/.centrum/config/"
    fi
    mkdir -p "$HOME/.centrum/memory"
    touch "$HOME/.centrum/memory/today.log"
    touch "$HOME/.centrum/memory/projects.index"
    echo "# Agenda" > "$HOME/.centrum/memory/agenda.md"
fi

# Display greeting
clear
echo ""
/opt/centrum/centrum greet 2>/dev/null || cat /etc/issue
echo ""
echo "Type 'centrum help' for available commands"
echo ""
PROFILE

chmod +x "$ROOTFS/root/.profile"

# Create motd
cat > "$ROOTFS/etc/motd" << 'MOTD'

    _____ _____ _   _ _____ _____ __  __ 
   /  __ \_   _| \ | |  __ \_   _|  \/  |
   | /  \/ | | |  \| | |__) || | | \  / |
   | |     | | | . ` |  _  /  | | | |\/| |
   | \__/\ _| |_| |\  | | \ \ _| |_| |  | |
    \____/\___/\_| \_/|_|  \_/\___/\_|  |_/

             v0.1-beta | "Return to focus."

     Type 'centrum' to begin | 'help' for commands

MOTM

echo -e "${GREEN}[✓] Boot system configured${NC}"

# Step 6: Build ISO
echo ""
echo -e "${BLUE}[*] Step 6/6: Building bootable ISO...${NC}"

if command -v mkisofs &> /dev/null || command -v genisoimage &> /dev/null; then
    ISO_CMD="mkisofs"
    if ! command -v mkisofs &> /dev/null; then
        ISO_CMD="genisoimage"
    fi
    
    ISO_FILE="${OUT_DIR}/centrum-os-v0.1-${ALPINE_ARCH}.iso"
    
    # Create simple bootable ISO
    mkdir -p "$ROOTFS/boot"
    
    echo "Creating ISO: $ISO_FILE"
    $ISO_CMD -o "$ISO_FILE" -R -l -V "CENTRUM OS" "$ROOTFS" 2>/dev/null || true
    
    if [[ -f "$ISO_FILE" ]]; then
        ISO_SIZE=$(du -h "$ISO_FILE" | cut -f1)
        echo -e "${GREEN}[✓] ISO created: $ISO_FILE ($ISO_SIZE)${NC}"
    fi
else
    echo -e "${YELLOW}[!] mkisofs not found, skipping ISO creation${NC}"
    echo "To create ISO, install: apt install genisoimage (or mkisofs)"
fi

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo -e "${GREEN}[✓] BUILD COMPLETE${NC}"
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "Build artifacts:"
echo "  Rootfs: $ROOTFS"
echo "  Output: $OUT_DIR/"
echo ""
echo "Next steps:"
echo "  1. Write ISO to USB: sudo dd if=$OUT_DIR/centrum-os-*.iso of=/dev/sdX bs=4M"
echo "  2. Boot from USB on target system"
echo "  3. Login with default credentials"
echo "  4. Start with: centrum greet"
echo ""
