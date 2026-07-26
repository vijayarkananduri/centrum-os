# Centrum OS - Download Instructions

## Where to Download

### Option 1: Clone from GitHub (Recommended)

```bash
# Clone repository
git clone https://github.com/vijayarkananduri/centrum-os.git

# Navigate to directory
cd centrum-os

# View files
ls -la
```

**URL:** https://github.com/vijayarkananduri/centrum-os

### Option 2: Download as ZIP

1. Go to: https://github.com/vijayarkananduri/centrum-os
2. Click **"Code"** button (green)
3. Click **"Download ZIP"**
4. Extract the ZIP file
5. Navigate to folder: `cd centrum-os-main`

### Option 3: GitHub Releases (Pre-built)

**Status:** Coming soon

Once v0.1 is stable:
- **ISO:** Download bootable Centrum OS ISO
- **Docker:** Pre-built Docker images
- **Packages:** APK/DEB packages for distributions

Will be available at:
https://github.com/vijayarkananduri/centrum-os/releases

---

## What You Get

After downloading, you'll have:

```
centrum-os/
├── src/                    # Source code
│   ├── centrum            # Main script
│   ├── modules/           # Feature modules
│   ├── lib/               # Libraries
│   └── config/            # Configuration
├── themes/                # Color schemes (5 themes)
├── build/                 # Build scripts
├── install.sh            # Installation script
├── Dockerfile            # Docker build file
├── test.sh               # Test suite
├── quickstart.sh         # Setup wizard
├── README.md             # Overview
├── INSTALL.md            # Installation guide
├── QUICKREF.md           # Quick reference
├── RELEASES.md           # Version info
├── CONFIG_REFERENCE.md   # Settings guide
├── PROJECT_CENTRUM_v1.0.md  # Full specification
├── LICENSE               # MIT License
└── .gitignore           # Git ignore file
```

---

## Installation from Download

### Method 1: User Installation

```bash
cd centrum-os

# Make installer executable
chmod +x install.sh

# Run installer
./install.sh

# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Test installation
centrum greet
```

**Time:** ~2 minutes

### Method 2: System Installation

```bash
cd centrum-os
chmod +x install.sh

# Install system-wide (requires sudo)
sudo ./install.sh --system

# Available to all users
centrum greet
```

### Method 3: Docker

```bash
cd centrum-os

# Build Docker image
docker build -t centrum-os .

# Run container
docker run -it centrum-os

# Inside container
centrum greet
```

### Method 4: Run Tests First

```bash
cd centrum-os

# Make test script executable
chmod +x test.sh

# Run tests (before installing)
bash test.sh

# Then install if tests pass
./install.sh
```

---

## Release Files Available

### Currently Available
- ✅ **Source Code** (GitHub repo)
- ✅ **Documentation** (README, INSTALL, guides)
- ✅ **Installation Scripts** (install.sh)
- ✅ **Docker Build** (Dockerfile)
- ✅ **Test Suite** (test.sh)

### Coming Soon
- ⏳ **Pre-built ISO** (bootable media)
- ⏳ **Docker Images** (pre-built, ready to run)
- ⏳ **APK Packages** (Alpine Linux packages)
- ⏳ **DEB Packages** (Debian/Ubuntu packages)

---

## System Requirements

### Before Download
- ~50 MB disk space (for repository)
- ~2 GB for full installation

### To Run
- **OS:** Linux (Alpine, Ubuntu, Debian, etc.)
- **Bash:** 5.2+
- **Tools:** curl, git, grep, sed, awk
- **RAM:** 512 MB minimum
- **Storage:** 2 GB minimum

---

## Verify Download

### Check Git Clone

```bash
cd centrum-os

# Verify files
ls -la

# Check main script
file src/centrum

# Verify structure
tree src/  # or 'find src/'
```

### Verify Installation

```bash
# After running install.sh

# Check command exists
command -v centrum

# Test it works
centrum help

# Check configuration
cat ~/.centrum/config/centrum.conf
```

---

## Getting Help

### Quick Help
```bash
centrum help
centrum help focus  # Help for specific command
```

### Full Documentation
```bash
# In your directory
cat README.md           # Overview
cat INSTALL.md         # Installation guide
cat QUICKREF.md        # Quick reference
cat PROJECT_CENTRUM_v1.0.md  # Full spec
```

### Online
- **GitHub:** https://github.com/vijayarkananduri/centrum-os
- **Issues:** Report bugs on GitHub
- **Discussions:** Ask questions on GitHub

---

## Troubleshooting Download

### Git Clone Failed

```bash
# Try with --depth for faster clone
git clone --depth 1 https://github.com/vijayarkananduri/centrum-os.git

# Or download as ZIP instead
```

### ZIP Download Failed

1. Check internet connection
2. Try again after a few minutes
3. Or use git clone instead

### Installation Failed

```bash
# Check dependencies
bash test.sh

# Install missing tools
# On Alpine: apk add bash curl git
# On Ubuntu/Debian: apt install bash curl git
# On macOS: brew install bash curl git

# Then try install again
./install.sh
```

---

## Next Steps After Download

1. **Read Documentation:**
   ```bash
   cat README.md
   cat INSTALL.md
   ```

2. **Check Requirements:**
   ```bash
   bash test.sh
   ```

3. **Configure:**
   ```bash
   ./install.sh
   ```

4. **Quick Start:**
   ```bash
   bash quickstart.sh
   ```

5. **Start Using:**
   ```bash
   centrum greet
   ```

---

## Release Schedule

| Version | Status | Date | Notes |
|---------|--------|------|-------|
| v0.1-beta | ✅ Current | Jul 26, 2026 | Initial release |
| v0.2 | ⏳ Q3 2026 | - | Multi-user support |
| v0.5 | ⏳ Q4 2026 | - | Plugin system |
| v1.0 | ⏳ 2027 | - | Stable release |

---

## License

MIT License - Free to use, modify, and distribute

See LICENSE file for details

---

*Centrum OS v0.1-beta* | July 26, 2026 | "Return to focus."
