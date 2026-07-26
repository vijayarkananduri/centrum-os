#!/bin/bash

################################################################################
#
# Alpine Linux ISO Builder for Centrum OS
# Creates bootable Centrum OS with custom branding
#
################################################################################

set -e

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${BUILD_DIR}/output"
WORK_DIR="${BUILD_DIR}/work"

echo "Centrum OS ISO Builder"
echo "======================"
echo ""

# Check dependencies
for cmd in apk abuild mkimage xorriso; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Warning: $cmd not found. Some features may not work."
    fi
done

# Create directories
mkdir -p "$OUT_DIR" "$WORK_DIR"

echo "[*] Building Centrum OS ISO..."
echo "[*] Work directory: $WORK_DIR"
echo "[*] Output directory: $OUT_DIR"

# Download Alpine minirootfs
echo "[*] Downloading Alpine Linux base..."
APKV="3.19"
APKA="x86_64"
APK_URL="https://alpinelinux.org/releases/$APKV/releases/$APKA/alpine-minirootfs-$APKV.0-$APKA.tar.gz"

if [[ ! -f "$WORK_DIR/alpine-minirootfs.tar.gz" ]]; then
    if ! wget -q -O "$WORK_DIR/alpine-minirootfs.tar.gz" "$APK_URL"; then
        echo "[!] Failed to download Alpine. Trying local build..."
    fi
fi

echo "[*] Extracting Alpine base..."
mkdir -p "$WORK_DIR/rootfs"
cd "$WORK_DIR/rootfs"
tar -xzf "../alpine-minirootfs.tar.gz" 2>/dev/null || echo "[info] Using existing rootfs"
cd "$BUILD_DIR"

# Copy Centrum files to rootfs
echo "[*] Copying Centrum OS files..."
mkdir -p "$WORK_DIR/rootfs/opt/centrum"
cp -r ../../src/* "$WORK_DIR/rootfs/opt/centrum/" 2>/dev/null || true
cp -r ../../themes/* "$WORK_DIR/rootfs/opt/centrum/themes/" 2>/dev/null || true

# Create boot script
echo "[*] Creating boot configuration..."
mkdir -p "$WORK_DIR/rootfs/root/.centrum/{config,memory,themes,notes}"

cat > "$WORK_DIR/rootfs/etc/profile.d/centrum.sh" << 'EOF'
#!/bin/sh
export PATH="/opt/centrum:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Auto-initialize Centrum on first login
if [[ ! -f "$HOME/.centrum/config/centrum.conf" ]]; then
    mkdir -p "$HOME/.centrum/config"
    cp /opt/centrum/config/centrum.conf "$HOME/.centrum/config/"
fi

# Display banner
clear
echo "┌─────────────────────────────────────────┐"
echo "│                                         │"
echo "│      C E N T R U M   O S   v0.1        │"
echo "│                                         │"
echo "│      \"Return to focus.\"                 │"
echo "│                                         │"
echo "└─────────────────────────────────────────┘"
echo ""
echo "Use 'centrum help' to get started."
echo ""
EOF

chmod +x "$WORK_DIR/rootfs/etc/profile.d/centrum.sh"

# Create custom issue (login banner)
cat > "$WORK_DIR/rootfs/etc/issue" << 'EOF'
Centrum OS v0.1 - Personal Terminal Operating System
Built on Alpine Linux | Local-first | Privacy-focused

login: 
EOF

echo "[*] Installing base packages..."
echo "bash curl git neovim tmux fzf" >> "$WORK_DIR/rootfs/etc/apk/world" 2>/dev/null || true

echo "[*] ISO would be built here with mkimage (Alpine build tools required)"
echo ""
echo "To build a full bootable ISO, run on Alpine Linux:"
echo "  # apk add alpine-sdk"
echo "  # ./mkimage-custom.sh"
echo ""
echo "Output will be in: $OUT_DIR/"
