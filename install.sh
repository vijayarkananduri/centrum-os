#!/bin/bash

################################################################################
#
# Centrum OS Installation Script
# Installs Centrum OS for development or user deployment
#
################################################################################

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
echo "┌─────────────────────────────────────────┐"
echo "│                                         │"
echo "│      C E N T R U M   O S   v0.1        │"
echo "│                                         │"
echo "│      \"Return to focus.\"                 │"
echo "│                                         │"
echo "└─────────────────────────────────────────┘"
echo -e "${NC}"

echo -e "${YELLOW}Installing Centrum OS...${NC}"

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

# Copy configuration files
echo -e "${BLUE}[*] Installing configuration files...${NC}"
if [[ -f "src/config/centrum.conf" ]]; then
    cp src/config/centrum.conf ~/.centrum/config/centrum.conf.default
fi
echo -e "${GREEN}[✓] Configuration installed${NC}"

# Create main executable script
echo -e "${BLUE}[*] Installing Centrum Commander...${NC}"
mkdir -p ~/.local/bin
mkdir -p ~/.local/lib/centrum/{modules,lib}

# Copy main script
cp src/centrum ~/.local/bin/centrum
chmod +x ~/.local/bin/centrum
echo -e "${GREEN}[✓] Centrum Commander installed to ~/.local/bin/centrum${NC}"

# Copy modules
echo -e "${BLUE}[*] Installing modules...${NC}"
cp src/modules/*.sh ~/.local/lib/centrum/modules/ 2>/dev/null || echo "[info] Creating module directory"
cp src/lib/*.sh ~/.local/lib/centrum/lib/ 2>/dev/null || echo "[info] Creating lib directory"
echo -e "${GREEN}[✓] Modules installed${NC}"

# Copy themes
echo -e "${BLUE}[*] Installing themes...${NC}"
cp themes/*.theme ~/.centrum/themes/ 2>/dev/null || echo "[info] Using default themes"
echo -e "${GREEN}[✓] Themes installed${NC}"

# Add to PATH if not already present
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo -e "${YELLOW}[!] ~/.local/bin not in PATH${NC}"
    echo "    Add this to your ~/.bashrc or ~/.zshrc:"
    echo "    export PATH=\"$HOME/.local/bin:\$PATH\""
    echo ""
fi

# Initialize memory files
echo -e "${BLUE}[*] Initializing memory system...${NC}"
touch ~/.centrum/memory/today.log
touch ~/.centrum/memory/projects.index
echo "# Agenda — $(date +%Y-%m-%d)" > ~/.centrum/memory/agenda.md
echo -e "${GREEN}[✓] Memory system initialized${NC}"

echo ""
echo -e "${GREEN}✓ Installation complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Add to PATH: export PATH=\"$HOME/.local/bin:\$PATH\""
echo "  2. Configure: centrum config USER_NAME \"Your Name\""
echo "  3. Start: centrum greet"
echo ""
echo "For help: centrum help"
echo ""
