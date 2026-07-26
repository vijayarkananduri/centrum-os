#!/bin/bash

################################################################################
#
# OVERLAY BUILDER
# Creates custom files for Alpine overlay (Phase 4)
#
################################################################################

set -e

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OVERLAY_DIR="${BUILD_DIR}/overlay"

echo "Creating Alpine Overlay for Centrum OS"
echo "======================================="
echo ""

# Create directory structure
mkdir -p "$OVERLAY_DIR"/{etc,root,usr/bin,opt}

echo "[*] Creating overlay directory structure..."

# Copy Centrum binaries
echo "[*] Copying Centrum executables..."
mkdir -p "$OVERLAY_DIR/opt/centrum"
cp -r ../../src/* "$OVERLAY_DIR/opt/centrum/" 2>/dev/null || true
cp -r ../../themes/* "$OVERLAY_DIR/opt/centrum/themes/" 2>/dev/null || true

# Create symlink in /usr/bin
echo "[*] Creating system links..."
cat > "$OVERLAY_DIR/usr/bin/centrum" << 'EOF'
#!/bin/sh
/opt/centrum/centrum "$@"
EOF
chmod +x "$OVERLAY_DIR/usr/bin/centrum"

# Create root home directory setup
echo "[*] Creating home directory template..."
mkdir -p "$OVERLAY_DIR/root/.centrum/config"
mkdir -p "$OVERLAY_DIR/root/.centrum/memory"
mkdir -p "$OVERLAY_DIR/root/.centrum/themes"

echo "[*] Creating login profile..."
cat > "$OVERLAY_DIR/etc/profile" << 'EOF'
#!/bin/sh
# Alpine default profile
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

# Centrum OS setup
if [[ -f /etc/profile.d/centrum.sh ]]; then
    source /etc/profile.d/centrum.sh
fi

# Show greeting
if [[ -t 0 ]]; then
    clear
    /opt/centrum/centrum greet 2>/dev/null || true
fi
EOF

echo "[*] Creating boot greeting..."
cat > "$OVERLAY_DIR/etc/issue" << 'EOF'
Centrum OS v0.1 - Personal Terminal Operating System
Built on Alpine Linux | Local-first | Privacy-focused

log in as: 
EOF

echo "[*] Creating motd (message of the day)..."
cat > "$OVERLAY_DIR/etc/motd" << 'EOF'

    _____ _____ _   _ _____ _____ __  __ 
   /  __ \_   _| \ | |  __ \_   _|  \/  |
   | /  \/ | | |  \| | |__) || | | \  / |
   | |     | | | . ` |  _  /  | | | |\/| |
   | \__/\ _| |_| |\  | | \ \ _| |_| |  | |
    \____/\___/\_| \_/|_|  \_/\___/\_|  |_/

"Return to focus."

Type 'centrum help' for available commands.
Type 'centrum greet' for daily overview.

EOF

echo "[*] Overlay created successfully!"
echo "[*] Overlay directory: $OVERLAY_DIR"
echo ""
echo "To integrate into Alpine ISO build:"
echo "  1. Run Alpine mkimage with -o $OVERLAY_DIR"
echo "  2. Or copy overlay contents to rootfs before building ISO"
