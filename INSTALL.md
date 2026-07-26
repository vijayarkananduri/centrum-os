# Centrum OS v0.1-beta Release Guide

## Overview

Centrum OS is a complete personal terminal operating system. This guide covers:
- How to download and install
- How to build the bootable ISO
- How to run in Docker
- How to deploy to a real system

---

## Installation Methods

### Method 1: User Installation (Easiest)

Install Centrum OS for your current user only:

```bash
# Clone the repository
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os

# Make installer executable
chmod +x install.sh

# Install
./install.sh

# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Start using
centrum greet
```

**Requirements:**
- bash 5.2+
- curl, git, grep, sed, awk

**Installation Time:** ~2 minutes

---

### Method 2: System-Wide Installation

Install for all users on the system:

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os

# System-wide install (requires sudo)
sudo ./install.sh --system

# Now any user can run
centrum greet
```

**Installation Time:** ~2 minutes

---

### Method 3: Docker Container

Run Centrum OS in a Docker container:

```bash
# Clone repo
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os

# Build Docker image
docker build -t centrum-os:latest .

# Run interactive container
docker run -it --name centrum-dev centrum-os:latest

# Inside container
centrum greet
centrum help
```

**Requirements:**
- Docker installed
- ~500MB disk space

**Installation Time:** ~1 minute (after image builds)

---

### Method 4: Bootable ISO (Complete OS)

Build a complete Centrum OS bootable ISO:

#### Prerequisites

You need Alpine Linux to build the ISO:

```bash
# Option A: On Alpine Linux directly
apk add alpine-sdk build-base abuild

# Option B: In Alpine Docker container
docker run -it -v /path/to/centrum-os:/work alpine:3.19 sh
apk add alpine-sdk build-base abuild
cd /work
```

#### Build Steps

```bash
cd centrum-os/build

# Make builder executable
chmod +x mkimage-custom.sh overlay-builder.sh

# Build overlay
bash overlay-builder.sh

# Build ISO
bash mkimage-custom.sh

# Output ISO in: build/output/
```

**Output:** `centrum-os-v0.1-x86_64.iso` (~100-150MB)

**Installation Time:** ~5-10 minutes

---

## Downloading Pre-Built Images

### GitHub Releases (Coming Soon)

When v0.1 is finalized:

```bash
# Download from GitHub releases
wget https://github.com/vijayarkananduri/centrum-os/releases/download/v0.1-beta/centrum-os-v0.1-x86_64.iso

# Or using curl
curl -L -O https://github.com/vijayarkananduri/centrum-os/releases/download/v0.1-beta/centrum-os-v0.1-x86_64.iso
```

---

## Running the ISO

### Option A: USB Flash Drive

```bash
# Write ISO to USB (on Linux)
sudo dd if=centrum-os-v0.1-x86_64.iso of=/dev/sdX bs=4M status=progress
sync

# Where /dev/sdX is your USB device (check with: lsblk)
# WARNING: This will erase the USB drive!
```

### Option B: Virtual Machine

**VirtualBox:**
```bash
# Create new VM
# Settings: Linux / Other Linux (64-bit)
# Storage: Attach ISO as CD/DVD
# Boot from ISO
```

**QEMU:**
```bash
qemu-system-x86_64 -m 2G -smp 2 -cdrom centrum-os-v0.1-x86_64.iso
```

**Hyper-V:**
- Create new VM → Generation 2 → Assign ISO → Boot

### Option C: Bare Metal

1. Insert USB drive with Centrum OS ISO
2. Boot from USB (F12, F2, ESC during startup)
3. Follow installation prompts
4. System boots into Centrum OS

---

## First Time Setup

After installation/boot:

```bash
# 1. View greeting
centrum greet

# 2. Configure your name
centrum config USER_NAME "Your Name"

# 3. Set project paths (optional)
centrum config PROJECT_PATHS "/home/user/projects:/home/user/work"

# 4. Quick start
bash quickstart.sh

# 5. View help
centrum help
```

---

## Version Information

```
Centrum OS v0.1-beta
Release Date: July 26, 2026
Base OS: Alpine Linux 3.19
Kernel: Linux 6.x LTS
Size: ~2GB (full install)
Footprint: ~500MB (core)
```

---

## System Requirements

### Minimum
- **CPU:** 1 GHz x86_64 or ARM64
- **RAM:** 512 MB
- **Storage:** 2 GB
- **Display:** Terminal (no GUI required)

### Recommended
- **CPU:** 2+ cores
- **RAM:** 2 GB+
- **Storage:** 10 GB
- **Terminal:** Modern terminal emulator (iTerm2, Alacritty, Kitty)

---

## File Structure After Installation

```
~/.centrum/
├── config/
│   └── centrum.conf           # Your settings
├── memory/
│   ├── today.log              # Today's activity
│   ├── yesterday.log          # Yesterday's activity
│   ├── projects.index         # Project registry
│   ├── agenda.md              # Today's tasks
│   └── notes/                 # Archived daily notes
└── themes/
    ├── day.theme              # Day color scheme
    ├── night.theme            # Night color scheme
    ├── dawn.theme             # Dawn color scheme
    ├── dusk.theme             # Dusk color scheme
    └── paper.theme            # Paper color scheme

~/.local/bin/
└── centrum                    # Main executable

~/.local/lib/centrum/
├── modules/                   # Feature modules
├── lib/                       # Core libraries
```

---

## Troubleshooting

### Command Not Found

```bash
# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Make permanent in ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Permission Denied

```bash
# Fix permissions
chmod +x ~/.local/bin/centrum
chmod +x ~/.local/lib/centrum/modules/*.sh
chmod +x ~/.local/lib/centrum/lib/*.sh
```

### Memory Files Missing

```bash
# Reinitialize
mkdir -p ~/.centrum/{config,memory,themes,notes}
touch ~/.centrum/memory/{today.log,yesterday.log,projects.index}
echo "# Agenda — $(date +%Y-%m-%d)" > ~/.centrum/memory/agenda.md
```

### Docker Container Issues

```bash
# Remove and rebuild
docker stop centrum-dev
docker rm centrum-dev
docker rmi centrum-os:latest
docker build -t centrum-os:latest .
docker run -it --name centrum-dev centrum-os:latest
```

---

## Common Commands

```bash
# Daily workflow
centrum greet              # Start your day
centrum agenda list        # See tasks
centrum work my-project    # Open project
centrum focus 45           # 45-min focus session
centrum agenda done 1      # Mark task complete
centrum save "Note here"   # Quick note
centrum yesterday          # Previous day report
centrum status             # System dashboard

# Configuration
centrum config USER_NAME "Name"              # Set name
centrum config PROJECT_PATHS "/path:..."     # Set project paths
centrum config EDITOR "vim"                  # Change editor
centrum theme night                          # Night theme
centrum theme auto                           # Auto-theme by time

# Help
centrum help               # All commands
centrum help focus         # Help for specific command
```

---

## Next Steps

1. **Install:** Choose your method above
2. **Configure:** Run `quickstart.sh` or manual setup
3. **Explore:** Try `centrum help` and experiment
4. **Customize:** Edit `~/.centrum/config/centrum.conf`
5. **Contribute:** Submit issues/PRs to GitHub

---

## Support & Links

- **GitHub:** https://github.com/vijayarkananduri/centrum-os
- **Documentation:** See PROJECT_CENTRUM_v1.0.md
- **Issues:** GitHub Issues
- **Discussions:** GitHub Discussions

---

## License

MIT License - See LICENSE file

---

*Centrum OS: Because your terminal should know you.*
