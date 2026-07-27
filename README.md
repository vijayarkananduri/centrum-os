# Centrum OS — Personal Terminal Operating System

**Beta v0.1** | "Return to focus."

A minimal, local-first terminal operating system built on Alpine Linux. Remembers your work, manages your focus, and feels uniquely yours.

## What is Centrum OS?

Centrum OS is a complete personal operating system that transforms your terminal into a context-aware productivity companion. It:

- 📝 **Remembers** your projects, activities, and daily patterns
- ⏱️ **Manages** focused work sessions with timers and progress tracking
- 📋 **Tracks** daily tasks and goals with an integrated agenda
- 🎨 **Adapts** to your time of day with automatic theme switching
- 🔒 **Keeps** everything local — no cloud, no tracking, no telemetry
- 🚀 **Boots** as a complete operating system or runs on any Linux

## Quick Install

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
chmod +x install.sh
./install.sh

# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Start
centrum greet
```

**Installation time:** ~2 minutes

## Core Features

### 🎯 Focus Mode
Timed work sessions with countdown, progress tracking, and project logging.

```bash
centrum focus 45         # 45-minute focus session
centrum focus 90 my-project  # Focus on specific project
```

### 📅 Agenda Manager
Daily task tracking with completion status and priority management.

```bash
centrum agenda list      # View today's tasks
centrum agenda add "Task description"
centrum agenda done 1    # Mark task 1 complete
```

### 🎁 Time-Based Greeting
Personalized greetings that adapt to your time of day (dawn, morning, afternoon, evening, night).

```bash
centrum greet   # Shows your daily overview
```

### 📊 Activity Dashboard
Real-time view of your productivity metrics and system status.

```bash
centrum status  # View today's work summary
centrum yesterday  # Yesterday's activity report
```

### 🎨 Theme System
Automatically switch between 5 color schemes based on time or preference.

```bash
centrum theme day       # Bright theme
centrum theme night     # Dark theme
centrum theme auto      # Auto-switch by time
```

### 📚 Project Management
Open and track projects with fuzzy matching and history.

```bash
centrum work my-project  # Open project
centrum open web         # Fuzzy search for project
```

### 📰 News Fetcher
Read headlines without leaving the terminal.

```bash
centrum news hackernews  # Fetch Hacker News headlines
```

### 📝 Quick Notes
Save thoughts and reminders instantly.

```bash
centrum save "Remember this important thing"
```

## Available Commands

| Command | Purpose |
|---------|----------|
| `centrum greet` | Daily greeting & overview |
| `centrum work [project]` | Open/manage projects |
| `centrum focus [minutes]` | Start timed focus session |
| `centrum agenda [list\|add\|done]` | Manage daily tasks |
| `centrum status` | View productivity dashboard |
| `centrum yesterday` | Previous day's activity report |
| `centrum save "note"` | Quick note saving |
| `centrum theme [day\|night\|auto]` | Change color scheme |
| `centrum news [source]` | Fetch headlines |
| `centrum config [key] [value]` | Manage settings |
| `centrum help` | Show all commands |

## Installation Methods

### User Installation (Recommended)
```bash
./install.sh
```

### System Installation
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
cd build
bash mkimage-custom.sh  # Requires Alpine Linux
```

See [INSTALL.md](./INSTALL.md) for detailed installation instructions.

## Directory Structure

After installation, Centrum creates:

```
~/.centrum/
├── config/
│   └── centrum.conf          # Your settings
├── memory/
│   ├── today.log             # Today's activity log
│   ├── yesterday.log         # Yesterday's activity
│   ├── projects.index        # Your projects
│   ├── agenda.md             # Daily tasks
│   └── notes/                # Saved notes
└── themes/
    ├── day.theme             # Bright theme
    ├── night.theme           # Dark theme
    ├── dawn.theme            # Warm theme
    ├── dusk.theme            # Calm theme
    └── paper.theme           # Reading theme
```

## Getting Started

### 1. Configure Your Name
```bash
centrum config USER_NAME "Your Name"
```

### 2. View Your Greeting
```bash
centrum greet
```

### 3. Add Tasks
```bash
centrum agenda add "First task"
centrum agenda add "Second task"
centrum agenda list
```

### 4. Try Focus Mode
```bash
centrum focus 5  # 5-minute test session
```

### 5. Check Your Status
```bash
centrum status
```

## System Requirements

- **OS:** Linux (Alpine, Ubuntu, Debian, etc.)
- **Bash:** 5.2 or newer
- **Tools:** curl, git, grep, sed, awk
- **RAM:** 512 MB minimum
- **Storage:** 2 GB minimum

## Configuration

Edit `~/.centrum/config/centrum.conf` to customize:

```bash
# User settings
USER_NAME="Your Name"
USER_EMAIL="your@email.com"

# Project paths (colon-separated)
PROJECT_PATHS="$HOME/projects:$HOME/work"

# Editor and browser
EDITOR="nvim"    # or vim, nano, etc.
BROWSER="w3m"    # text-based browser

# Behavior
AUTO_GREET="true"
THEME_AUTO="true"
FOCUS_DEFAULT_MINUTES="45"
```

## How It Works

### Memory System
Centrum logs every activity (project opened, focus session completed, task added, etc.) to plain text files. This allows:
- Automatic activity tracking
- Previous day analysis
- Pattern recognition
- Complete data transparency (you can read all files)

### Context Engine
Based on time of day and recent activity, Centrum determines:
- Which greeting to show (dawn/morning/afternoon/evening/night)
- Which theme to apply (auto-theme)
- Recent project history
- Daily task progress

### Local-First Design
All data stays on your machine:
- No cloud sync
- No external APIs for core features
- No telemetry or tracking
- Complete privacy by design

## Philosophy

Centrum OS is built on five core principles:

1. **Memory over Magic** — Remembers through careful logging, not AI
2. **Context over Commands** — Understands your situation and work
3. **Focus over Features** — Every feature serves productivity
4. **Local over Cloud** — All data stays on your machine
5. **Transparency over Complexity** — Everything is readable and modifiable

## Examples

### Morning Routine
```bash
centrum greet                    # See your daily overview
centrum work web-scraper         # Open yesterday's project
centrum agenda list              # Review tasks
centrum focus 90                 # Start deep work session
```

### Afternoon Check-in
```bash
centrum status                   # Check productivity
centrum agenda done 1            # Mark task complete
centrum save "Remember edge case"  # Save note
```

### End of Day
```bash
centrum yesterday                # Tomorrow's report (today's activity)
centrum theme night              # Switch to night theme
```

## Troubleshooting

### Command not found
```bash
export PATH="$HOME/.local/bin:$PATH"
# Add to ~/.bashrc to make permanent
```

### Permission denied
```bash
chmod +x ~/.local/bin/centrum
chmod +x ~/.local/lib/centrum/modules/*.sh
chmod +x ~/.local/lib/centrum/lib/*.sh
```

### Missing configuration
```bash
mkdir -p ~/.centrum/{config,memory,themes,notes}
touch ~/.centrum/memory/{today.log,projects.index}
echo "# Agenda" > ~/.centrum/memory/agenda.md
```

For more help, see [DOWNLOAD.md](./DOWNLOAD.md) or run `centrum help`.

## Documentation

- **[INSTALL.md](./INSTALL.md)** — Installation guide with all methods
- **[DOWNLOAD.md](./DOWNLOAD.md)** — Download and setup instructions
- **[QUICKREF.md](./QUICKREF.md)** — Quick command reference
- **[RELEASES.md](./RELEASES.md)** — Version history and roadmap
- **[PROJECT_CENTRUM_v1.0.md](./PROJECT_CENTRUM_v1.0.md)** — Full technical specification
- **[CONFIG_REFERENCE.md](./CONFIG_REFERENCE.md)** — Configuration options

## License

MIT License — Free and open source

See [LICENSE](./LICENSE) file for details.

## Support

- **Bug Reports:** [GitHub Issues](https://github.com/vijayarkananduri/centrum-os/issues)
- **Questions:** [GitHub Discussions](https://github.com/vijayarkananduri/centrum-os/discussions)
- **Repository:** [github.com/vijayarkananduri/centrum-os](https://github.com/vijayarkananduri/centrum-os)

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Roadmap

**v0.1** (Current) — Foundation and core features

**Future:**
- Multi-user support
- Git integration
- Plugin system
- Advanced analytics
- Mobile companion

---

**Centrum OS: Because your terminal should know you.**

*Built with focus. Designed for privacy. Made for you.*
