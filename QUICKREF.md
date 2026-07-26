# Centrum OS - Quick Reference

## Installation

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
./install.sh
export PATH="$HOME/.local/bin:$PATH"
centrum greet
```

## Core Commands

| Command | Purpose | Example |
|---------|---------|----------|
| `greet` | Daily greeting & overview | `centrum greet` |
| `work` | Open/manage projects | `centrum work web-scraper` |
| `focus` | Timed focus sessions | `centrum focus 45` |
| `agenda` | Daily task management | `centrum agenda list` |
| `status` | System & productivity stats | `centrum status` |
| `yesterday` | Previous day report | `centrum yesterday` |
| `save` | Quick notes | `centrum save "Remember this"` |
| `theme` | Change colors | `centrum theme night` |
| `news` | Fetch headlines | `centrum news hackernews` |
| `config` | User settings | `centrum config USER_NAME "Name"` |
| `help` | Documentation | `centrum help` |

## Directory Structure

```
centrum-os/
├── src/
│   ├── centrum              # Main script
│   ├── modules/             # Features (greet, work, focus, etc)
│   ├── lib/                 # Libraries (memory, UI, time, config)
│   └── config/              # Default config
├── themes/                  # Color schemes
├── build/
│   ├── mkimage-custom.sh   # ISO builder
│   └── overlay-builder.sh  # Alpine overlay
├── install.sh              # Installation script
├── Dockerfile              # Docker build
├── test.sh                 # Test suite
├── quickstart.sh           # Setup wizard
└── INSTALL.md              # Full installation guide
```

## Installation Methods

### User Install (Recommended)
```bash
./install.sh
```

### System Install
```bash
sudo ./install.sh --system
```

### Docker
```bash
docker build -t centrum-os .
docker run -it centrum-os
```

### Bootable ISO
```bash
# Requires Alpine Linux
cd build
bash mkimage-custom.sh
```

## First Time

```bash
# 1. Configure
centrum config USER_NAME "Your Name"

# 2. View greeting
centrum greet

# 3. Add tasks
centrum agenda add "My first task"

# 4. Check status
centrum status
```

## Project Structure

```
~/.centrum/
├── config/centrum.conf     # Settings
├── memory/
│   ├── today.log           # Session log
│   ├── agenda.md           # Tasks
│   ├── projects.index      # Project registry
│   └── notes/              # Archived notes
└── themes/                 # Color schemes
```

## Keyboard Shortcuts

```
Ctrl+C     - Cancel/exit
Ctrl+D     - Logout
Ctrl+L     - Clear screen
Tab        - Auto-complete (if available)
```

## Troubleshooting

```bash
# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Fix permissions
chmod +x ~/.local/bin/centrum

# Reinitialize
mkdir -p ~/.centrum/{config,memory,themes,notes}
touch ~/.centrum/memory/{today.log,projects.index}
echo "# Agenda" > ~/.centrum/memory/agenda.md

# Test installation
bash test.sh
```

## Environment Variables

```bash
USER_NAME          # Your name
PROJECT_PATHS      # Project directories
EDITOR             # Default editor
THEME_AUTO         # Auto-switch theme
FOCUS_DEFAULT_MINUTES  # Default focus duration
```

## File Permissions

```
~/.centrum/                700   (rwx------)
~/.centrum/config/         700   (rwx------)
~/.centrum/memory/         700   (rwx------)
~/.centrum/memory/*.log    600   (rw-------)
```

## Support

- **Documentation:** See PROJECT_CENTRUM_v1.0.md
- **GitHub:** https://github.com/vijayarkananduri/centrum-os
- **Tests:** Run `bash test.sh`
- **Help:** Run `centrum help`

## License

MIT License - Free and open source

---

**Centrum OS v0.1-beta** | "Return to focus." | July 26, 2026
