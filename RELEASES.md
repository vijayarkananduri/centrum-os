# Releases

## v0.1-beta (Current)

**Release Date:** July 26, 2026

### Features
- ✅ Core Centrum Commander with command router
- ✅ Context-aware memory system with activity logging
- ✅ Time-based greeting engine (dawn/morning/afternoon/evening/night)
- ✅ Project management and fuzzy opener
- ✅ Focus mode with timer and progress tracking
- ✅ Agenda manager with task tracking
- ✅ Daily activity reports (yesterday module)
- ✅ System status dashboard
- ✅ Theme system (day, night, dawn, dusk, paper)
- ✅ News fetcher (Hacker News, Lobsters)
- ✅ Configuration management
- ✅ Docker support
- ✅ Alpine ISO builder
- ✅ Full documentation

### Installation Methods
- User installation (`./install.sh`)
- System installation (`sudo ./install.sh --system`)
- Docker (`docker build -t centrum-os .`)
- Bootable ISO (requires Alpine Linux)

### Download

#### Source Code
```bash
git clone https://github.com/vijayarkananduri/centrum-os.git
cd centrum-os
./install.sh
```

#### Docker Image
```bash
docker build -t centrum-os:latest .
docker run -it centrum-os:latest
```

#### Pre-built ISO (Coming Soon)
- Will be available at: https://github.com/vijayarkananduri/centrum-os/releases/

### System Requirements
- **OS:** Linux (Alpine, Ubuntu, Debian, etc.)
- **Bash:** 5.2+
- **Dependencies:** curl, git, grep, sed, awk, find
- **RAM:** 512 MB minimum
- **Storage:** 2 GB minimum

### Known Limitations
- ISO building requires Alpine Linux build tools
- Some features (news fetcher) require internet connection
- No GUI applications (terminal-only)
- No multi-user support in this beta

### Roadmap

#### v0.2 (Q3 2026)
- [ ] Multi-user support
- [ ] Advanced project management
- [ ] Git integration
- [ ] Syntax highlighting for logs
- [ ] Performance optimizations
- [ ] Extended documentation

#### v0.5 (Q4 2026)
- [ ] Plugin system
- [ ] Custom themes builder
- [ ] Integration with external tools (GitHub, GitLab)
- [ ] Advanced analytics
- [ ] Mobile companion app

#### v1.0 (2027)
- [ ] Stable API
- [ ] Large-scale testing
- [ ] Production deployment
- [ ] Community contributions

### Contributors
- **Creator:** Vijay Arkananduri
- **Contributors:** Community (you!)

### License
MIT License - Free and open source

### Support
- **Bug Reports:** GitHub Issues
- **Feature Requests:** GitHub Discussions
- **Documentation:** See docs/ and PROJECT_CENTRUM_v1.0.md

---

*Centrum OS: Because your terminal should know you.*
