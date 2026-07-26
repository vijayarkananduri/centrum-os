# Centrum OS — Personal Terminal Operating System

**Beta v0.1** | "Return to focus."

A minimal, local-first terminal operating system built on Alpine Linux that remembers your work, manages your focus, and feels uniquely yours.

## Quick Start

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
chmod +x install.sh
./install.sh
```

## Features

- 📝 **Context-Aware Memory** — Remembers projects, files, and daily patterns
- 🧘 **Focus Mode** — Timed work sessions with distraction blocking
- 📋 **Agenda Manager** — Daily task tracking integrated into workflow
- 🌍 **Time-Based Greetings** — Personalized feedback based on time of day
- 🎨 **Theme System** — Day/night/dawn/dusk color schemes
- 🔍 **Fuzzy Opener** — Open projects and files by partial name
- 📰 **News Fetcher** — Optional on-demand headlines
- 🔐 **Privacy First** — All data local, no cloud, no telemetry

## Quick Commands

```bash
centrum greet          # Time-based greeting and daily overview
centrum work [proj]    # Open a project
centrum focus [min]    # Start focused work session
centrum agenda [add]   # Manage daily tasks
centrum status         # View system stats and activity
centrum yesterday      # Yesterday's activity report
centrum theme [day]    # Change color scheme
centrum help           # Full command list
```

## Project Structure

```
centrum-os/
├── src/
│   ├── centrum              # Main executable
│   ├── modules/             # Feature modules (greet, work, focus, etc.)
│   ├── lib/                 # Core libraries (memory, UI, time, config)
│   └── config/              # Default configuration
├── themes/                  # Terminal color schemes
├── build/                   # ISO and packaging scripts
├── install.sh               # User installation script
├── PROJECT_CENTRUM_v1.0.md  # Full specification
└── README.md
```

## Documentation

See [PROJECT_CENTRUM_v1.0.md](./PROJECT_CENTRUM_v1.0.md) for the complete specification including:
- Core philosophy and principles
- All feature specifications
- Technical architecture
- Data schemas
- Development roadmap

## Development Status

### Phase 1: Foundation (In Progress) ✓
- [x] Main script with command router
- [x] Greet module with time-based logic
- [x] Work module with project detection
- [x] Memory system (read/write logs)
- [x] Agenda manager skeleton
- [x] Status dashboard
- [x] Configuration system
- [x] Core libraries (UI, time, memory, config)
- [ ] Testing and debugging

### Phase 2: Core Features (Coming)
- [ ] Yesterday report generator
- [ ] Full agenda functionality
- [ ] Enhanced focus mode
- [ ] Fuzzy file/project opener
- [ ] Theme system implementation
- [ ] Save/note module

### Phase 3: Polish (Coming)
- [ ] News fetcher
- [ ] Error handling and edge cases
- [ ] Default themes (day, night, dawn, dusk)
- [ ] Help system and documentation

### Phase 4: Packaging (Coming)
- [ ] Alpine ISO remastering
- [ ] ISO build scripts
- [ ] Boot customization
- [ ] Release packaging

## Installation

### User Installation

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
./install.sh

# Configure your name
centrum config USER_NAME "Your Name"

# Start using
centrum greet
```

### Development Setup

```bash
# Clone and navigate
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os

# Make scripts executable
chmod +x src/centrum install.sh
chmod +x src/lib/*.sh
chmod +x src/modules/*.sh

# Install for development
./install.sh

# Test
centrum help
```

## Requirements

- **Bash** 5.2+
- **Core utilities**: coreutils, grep, sed, awk, find
- **Optional**: curl (for news), git (for development)
- **Linux** (Alpine, Ubuntu, Debian, etc.)

## Directory Structure

After installation, Centrum creates:

```
~/.centrum/
├── config/
│   └── centrum.conf         # User preferences
├── memory/
│   ├── today.log            # Current session log
│   ├── yesterday.log        # Previous session log
│   ├── projects.index       # Project registry
│   ├── agenda.md            # Today's tasks
│   └── notes/               # Daily notes archive
└── themes/                  # Custom color schemes
```

## License

MIT License — See LICENSE file

## Philosophy

Centrum OS is built on five core principles:

1. **Memory over Magic** — Remembers through careful logging, not AI
2. **Context over Commands** — Understands your situation and work
3. **Focus over Features** — Every feature serves productivity
4. **Local over Cloud** — All data stays on your machine
5. **Transparency over Complexity** — Everything is readable and modifiable

---

*Centrum OS: Because your terminal should know you.*
