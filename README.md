```
 ░▒▓██████▓▒░░▒▓████████▓▒░▒▓███████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓██████████████▓▒░  
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ 
                                                                                                   
                                                                                                   

         Personal Terminal Operating System
              v0.1-beta | "Return to focus."
```

---

## What is Centrum OS?

Centrum OS is a complete, minimal operating system built on Alpine Linux. It combines the power of Linux with an intelligent, context-aware terminal interface that remembers your work, manages your focus, and adapts to your workflow.

**Your terminal now knows you.**

### Core Features

🎯 **Focus Mode**  
Timed work sessions with progress tracking and distraction logging.

📋 **Agenda Manager**  
Daily task tracking with completion status and automatic logging.

🕐 **Time-Based Adaptation**  
Personalized greetings, themes, and recommendations based on time of day.

📊 **Activity Dashboard**  
Real-time productivity metrics and daily activity summaries.

🎨 **5 Color Themes**  
Automatically switch themes (dawn, day, afternoon, evening, night) or set manually.

📁 **Smart Project Management**  
Quickly open projects with fuzzy search and automatic history tracking.

💾 **Local-First by Design**  
All data stays on your machine. No cloud, no tracking, no telemetry.

---

## Get Started in 3 Steps

### Step 1: Download

```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
```

### Step 2: Install

Choose your preferred method:

**Option A: Local User Install**
```bash
./install.sh
export PATH="$HOME/.local/bin:$PATH"
```

**Option B: System-Wide**
```bash
sudo ./install.sh --system
```

**Option C: Docker**
```bash
docker build -t centrum-os .
docker run -it centrum-os
```

**Option D: Bootable OS**
```bash
bash build/quick-build.sh  # Creates bootable ISO
```

### Step 3: Configure & Use

```bash
# Set your name
centrum config USER_NAME "Your Name"

# View your greeting
centrum greet

# Start working
centrum help  # See all commands
```

---

## Command Reference

```bash
centrum greet              # Daily greeting & overview
centrum work [project]     # Open/manage projects  
centrum focus [min]        # Timed focus session
centrum agenda [cmd]       # Manage tasks
centrum status             # Productivity dashboard
centrum yesterday          # Previous day report
centrum save "note"        # Quick notes
centrum theme [theme]      # Change colors
centrum news [source]      # Fetch headlines
centrum config [key] [val] # Configure settings
centrum help               # Show help
```

---

## System Requirements

- **OS:** Linux (Alpine, Ubuntu, Debian, Fedora, etc.)
- **Bash:** 5.2+
- **RAM:** 512 MB minimum (2 GB recommended)
- **Storage:** 2 GB minimum
- **Terminal:** Any modern terminal emulator

---

## How It Works

### Memory System
Every action is logged to local plain-text files:
- Projects opened
- Focus sessions completed
- Tasks accomplished
- Notes saved

You own your data. Read, modify, and understand everything.

### Context Engine
Based on time and activity, Centrum automatically:
- Adjusts greeting and theme
- Suggests relevant projects
- Shows productivity insights
- Adapts recommendations

### Local-First Philosophy
- No external API calls for core features
- No account required
- No data collection
- Complete privacy and control

---

## Use Cases

**Software Developers**  
Track projects, manage focus sessions, maintain daily logs.

**Writers & Researchers**  
Focus mode, distraction-free environment, daily notes.

**Students**  
Task management, study sessions, progress tracking.

**Privacy-Conscious Users**  
Local-only data, transparent logging, zero telemetry.

---

## Philosophy

Centrum OS is built on five core principles:

**Memory over Magic** — Remembers through logging, not AI  
**Context over Commands** — Understands your situation  
**Focus over Features** — Every feature serves productivity  
**Local over Cloud** — Data stays on your machine  
**Transparency over Complexity** — Everything is readable  

---

## Download Options

### Source Code
Clone from GitHub:
```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
```

### Bootable ISO
Build a complete operating system:
```bash
bash build/quick-build.sh
```

Boot on USB, VM, or bare metal. Complete operating system with Centrum OS pre-installed.

### Docker Image
Run instantly without installation:
```bash
docker build -t centrum-os .
docker run -it centrum-os
```

---

## Documentation

- **[INSTALL.md](./INSTALL.md)** — Complete installation guide
- **[QUICKREF.md](./QUICKREF.md)** — Quick command reference  
- **[RELEASES.md](./RELEASES.md)** — Version history and roadmap

---

## Quick Examples

### Morning
```bash
centrum greet           # View greeting and today's overview
centrum work backend    # Open backend project
centrum agenda list     # Review tasks
centrum focus 90        # Start deep work
```

### Afternoon
```bash
centrum status          # Check productivity
centrum agenda done 1   # Complete a task
centrum save "Note"     # Save reminder
```

### Evening
```bash
centrum yesterday       # Tomorrow's report (today's activity)
centrum theme night     # Switch to night theme
```

---

## Support & Community

- **Issues:** [GitHub Issues](https://github.com/vijayarkananduri/centrum-os/issues)
- **Discussions:** [GitHub Discussions](https://github.com/vijayarkananduri/centrum-os/discussions)
- **Repository:** [github.com/vijayarkananduri/centrum-os](https://github.com/vijayarkananduri/centrum-os)

---

## License

MIT License — Free and open source  
See [LICENSE](./LICENSE) for details

---

## Roadmap

**v0.1** (Current)  
Core features, memory system, focus mode, task management

**v0.5** (Q4 2026)  
Multi-user support, git integration, analytics

**v1.0** (2027)  
Stable release, plugin system, community contributions

---

```
  Centrum OS: Because your terminal should know you.
         Built with focus. Designed for privacy.
                    Made for you.
```
