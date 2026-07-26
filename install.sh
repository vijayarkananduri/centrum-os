#!/bin/bash

################################################################################
#
# COMPLETE INSTALLER WITH ISO SUPPORT
# Installs Centrum OS or prepares for ISO building
#
################################################################################

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="0.1-beta"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
ORANGE='\033[38;2;255;102;0m'
NC='\033[0m'

show_banner() {
    clear
    echo -e "${ORANGE}"
    echo "┌─────────────────────────────────────────┐"
    echo "│                                         │"
    echo "│      C E N T R U M   O S   v0.1        │"
    echo "│                                         │"
    echo "│      \"Return to focus.\"                 │"
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "${NC}"
}

install_user() {
    show_banner
    echo -e "${YELLOW}Installing Centrum OS for current user...${NC}"
    echo ""
    
    # Check dependencies
    echo -e "${BLUE}[*] Checking dependencies...${NC}"
    for cmd in bash curl git sed awk grep find; do
        if ! command -v "$cmd" &> /dev/null; then
            echo -e "${RED}[!] Missing required command: $cmd${NC}"
            exit 1
        fi
    done
    echo -e "${GREEN}[✓] All dependencies found${NC}"
    
    # Create .centrum directory structure
    echo -e "${BLUE}[*] Creating .centrum directory...${NC}"
    mkdir -p ~/.centrum/{config,memory,themes,notes}
    echo -e "${GREEN}[✓] Directory structure created${NC}"
    
    # Copy files
    echo -e "${BLUE}[*] Installing Centrum Commander...${NC}"
    mkdir -p ~/.local/bin
    mkdir -p ~/.local/lib/centrum/{modules,lib}
    
    cp "$SCRIPT_DIR/src/centrum" ~/.local/bin/centrum
    chmod +x ~/.local/bin/centrum
    echo -e "${GREEN}[✓] Centrum Commander installed${NC}"
    
    # Copy modules and libs
    echo -e "${BLUE}[*] Installing modules and libraries...${NC}"
    cp "$SCRIPT_DIR/src/modules"/*.sh ~/.local/lib/centrum/modules/ 2>/dev/null || true
    cp "$SCRIPT_DIR/src/lib"/*.sh ~/.local/lib/centrum/lib/ 2>/dev/null || true
    echo -e "${GREEN}[✓] Modules installed${NC}"
    
    # Copy themes
    echo -e "${BLUE}[*] Installing themes...${NC}"
    cp "$SCRIPT_DIR/themes"/*.theme ~/.centrum/themes/ 2>/dev/null || true
    echo -e "${GREEN}[✓] Themes installed${NC}"
    
    # Initialize memory
    echo -e "${BLUE}[*] Initializing memory system...${NC}"
    touch ~/.centrum/memory/today.log
    touch ~/.centrum/memory/projects.index
    echo "# Agenda — $(date +%Y-%m-%d)" > ~/.centrum/memory/agenda.md
    echo -e "${GREEN}[✓] Memory system initialized${NC}"
    
    # Install bashrc
    if [[ -f "$SCRIPT_DIR/build/bashrc-template" ]]; then
        echo -e "${BLUE}[*] Setting up shell configuration...${NC}"
        cat "$SCRIPT_DIR/build/bashrc-template" >> ~/.bashrc 2>/dev/null || true
        echo -e "${GREEN}[✓] Shell configured${NC}"
    fi
    
    echo ""
    echo -e "${GREEN}✓ Installation complete!${NC}"
    echo ""
    echo "${YELLOW}Next steps:${NC}"
    echo "  1. Add to PATH (if not already):"
    echo "     export PATH=\"$HOME/.local/bin:\$PATH\""
    echo ""
    echo "  2. Configure your name:"
    echo "     centrum config USER_NAME \"Your Name\""
    echo ""
    echo "  3. Start using:"
    echo "     centrum greet"
    echo ""
    echo "For help: centrum help"
    echo ""
}

install_system() {
    echo -e "${YELLOW}System-wide installation (requires sudo)...${NC}"
    echo ""
    
    echo -e "${BLUE}[*] Installing to /opt/centrum...${NC}"
    sudo mkdir -p /opt/centrum
    sudo cp -r "$SCRIPT_DIR/src" /opt/centrum/
    sudo cp -r "$SCRIPT_DIR/themes" /opt/centrum/
    
    echo -e "${BLUE}[*] Creating system symlink...${NC}"
    sudo ln -sf /opt/centrum/src/centrum /usr/local/bin/centrum
    sudo chmod +x /usr/local/bin/centrum
    
    echo -e "${GREEN}[✓] System installation complete${NC}"
    echo -e "${YELLOW}Centrum is now available as: centrum${NC}"
}

build_iso() {
    echo -e "${YELLOW}Building Centrum OS ISO...${NC}"
    echo ""
    
    if ! command -v mkimage &> /dev/null; then
        echo -e "${RED}[!] mkimage not found. This requires Alpine Linux build tools.${NC}"
        echo "Run on Alpine Linux:"
        echo "  apk add alpine-sdk"
        exit 1
    fi
    
    echo -e "${BLUE}[*] Starting ISO build process...${NC}"
    bash "$SCRIPT_DIR/build/mkimage-custom.sh"
}

show_help() {
    cat << 'EOF'
Centrum OS Installer v0.1-beta

USAGE:
  ./install.sh [OPTION]

OPTIONS:
  (no args)        Install for current user
  --system         System-wide installation (requires sudo)
  --iso            Build bootable ISO (requires Alpine Linux)
  --help           Show this help message

EXAMPLES:
  ./install.sh                    # User installation
  sudo ./install.sh --system      # System installation
  ./install.sh --iso              # Build ISO (on Alpine)

EOF
}

# Main
main() {
    case "${1:-}" in
        --system)
            show_banner
            install_system
            ;;
        --iso)
            show_banner
            build_iso
            ;;
        --help|-h|help)
            show_help
            ;;
        *)
            install_user
            ;;
    esac
}

main "$@"
