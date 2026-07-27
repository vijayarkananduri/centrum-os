# Centrum OS v0.1-beta

**Release Date:** July 27, 2026

## What's Included

### Core System
- ✅ Personal Terminal Operating System
- ✅ Complete Alpine Linux + Centrum OS integration
- ✅ Bootable ISO for bare metal installation
- ✅ Docker containerization for instant use
- ✅ Local user and system-wide installation options

### Features
- ✅ Context-aware greeting system (dawn/morning/afternoon/evening/night)
- ✅ Focus mode with timer and progress tracking
- ✅ Daily task/agenda management
- ✅ Activity logging and memory system
- ✅ Smart project opener with fuzzy search
- ✅ 5 color themes with auto-switching
- ✅ System status and productivity dashboard
- ✅ Daily activity reports and analytics
- ✅ News fetcher (Hacker News, Lobsters)
- ✅ Quick note saving
- ✅ Configuration management

### Installation Methods
- ✅ User local installation (`./install.sh`)
- ✅ System-wide installation (`sudo ./install.sh --system`)
- ✅ Docker deployment
- ✅ Bootable custom OS (ISO)
- ✅ One-command setup (`./setup.sh`)

### Documentation
- ✅ Clean, professional README
- ✅ Installation guide (INSTALL.md)
- ✅ Quick reference (QUICKREF.md)
- ✅ Complete technical specification
- ✅ Configuration reference

### Development & Testing
- ✅ Full test suite
- ✅ Quick start wizard
- ✅ ISO builders (direct + Docker-based)
- ✅ Build scripts and automation

---

## Download

### Option 1: Source Code
```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
```

### Option 2: Bootable ISO
```bash
cd centrum-os
bash build/quick-build.sh
```

Creates a complete operating system:
- Pre-installed Alpine Linux base
- Centrum OS fully integrated
- Auto-launching greeting on boot
- Ready to use immediately

### Option 3: Docker
```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
docker build -t centrum-os .
docker run -it centrum-os
```

---

## Quick Install

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
./install.sh
export PATH="$HOME/.local/bin:$PATH"
centrum greet
```

---

## System Requirements

- **OS:** Linux (Alpine, Ubuntu, Debian, etc.)
- **Bash:** 5.2+
- **RAM:** 512 MB minimum
- **Storage:** 2 GB minimum
- **Terminal:** Any modern terminal

---

## Bootable ISO Usage

### Write to USB
```bash
sudo dd if=centrum-os-v0.1-x86_64.iso of=/dev/sdX bs=4M status=progress
sync
```

### Run in VM
**VirtualBox:** Attach ISO, boot  
**QEMU:** `qemu-system-x86_64 -cdrom centrum-os-v0.1-x86_64.iso -m 2G`  
**Hyper-V:** Create Gen 2 VM, attach ISO

### Boot on Bare Metal
1. Insert USB with ISO
2. Boot from USB (F12/ESC during startup)
3. Follow prompts
4. Boots into Centrum OS

---

## Version Information

```
Centrum OS v0.1-beta
Release Date: July 27, 2026
Base: Alpine Linux 3.19
Kernel: Linux 6.x LTS
Size: 2GB (full install) | 500MB (minimal)
Architecture: x86_64, ARM64
```

---

## Known Limitations

- Beta release - use with caution in production
- ISO building requires internet for Alpine download
- Some features require internet (news fetcher)
- Single-user focus in this beta
- Terminal-only (no GUI)

---

## Future Roadmap

**v0.2** (Q3 2026)
- Multi-user support
- Advanced project management
- Git integration
- Extended themes

**v0.5** (Q4 2026)
- Plugin system
- Custom theme builder
- Analytics dashboard
- Community themes

**v1.0** (2027)
- Stable release
- Production deployment
- Community contributions
- Extended documentation

---

## License

MIT License — Free and open source

---

**Repository:** https://github.com/vijayarkananduri/centrum-os

*Centrum OS v0.1-beta | "Return to focus." | July 27, 2026*
