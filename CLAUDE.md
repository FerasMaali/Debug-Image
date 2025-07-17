# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a lightweight Docker debug image project that provides a minimal Ubuntu 24.04-based container with essential tools and on-demand installation capabilities via Taskfile. The image is automatically built and published to Docker Hub as `ferasmaali/dbg`.

## Key Commands

### Building the Docker Image
```bash
docker build -t dbg .
```

### Running the Debug Container
```bash
# Interactive mode
docker run -it --rm ferasmaali/dbg

# With network host access
docker run -it --rm --network host ferasmaali/dbg

# With volume mount for debugging local files
docker run -it --rm -v $(pwd):/workspace ferasmaali/dbg
```

### Installing Tools On-Demand
```bash
# Inside the container, use task to install tools
task --list          # Show all available tasks (or just run 'task')
task network         # Install network tools
task dev            # Install development tools
task tmux           # Install terminal multiplexer
task jq             # Install JSON processor
task mssql          # Install MS SQL tools (sqlcmd, bcp, sqlpackage)
task full           # Install everything
```

### Version Management
```bash
# Create and push a new version tag (increments automatically)
./push-version
```

### Testing Changes Locally
```bash
# Build and run locally before pushing
docker build -t dbg:local . && docker run -it --rm dbg:local
```

## Architecture & CI/CD

The project uses a minimal base image approach:
- **Base image (~150MB)**: Ubuntu 24.04 + BusyBox + git/vim/wget + moreutils + Taskfile
- **On-demand installations**: All other tools installable via `task` commands
- **Task completion**: Bash completion enabled for task commands
- **GitHub Actions**: Automatically builds and publishes to Docker Hub
- **Version tags**: Simple incremental pattern (v1, v2, v3, etc.)

## Important Files

- **Dockerfile**: Minimal base image with essentials only
- **Taskfile.yml**: Defines all on-demand installation tasks
- **push-version**: Shell script that automates version tagging
- **.github/workflows/docker.yml**: CI/CD pipeline configuration

## Available Tasks in Taskfile

The Taskfile provides installation tasks for:
- **Core Development**: python, build-tools, asdf
- **Networking**: All network debugging tools (nmap, tcpdump, etc.)
- **Monitoring**: htop, iotop, iftop
- **Database CLIs**: Azure CLI, MS SQL tools (combined), MongoDB shell
- **Terminal Utilities**: tmux (separate), jq (separate), enhanced vim config
- **Archive Tools**: zip, unzip, rar, gzip, xz
- **Debugging**: gdb, strace
- **Preset Combinations**: dev (basic dev setup), full (everything)
- **Default Task**: Shows all available tasks when running just 'task'

## Adding New Tools

When adding new tools to the Taskfile:
1. Create a new task in Taskfile.yml
2. Use the `APT_OPTIONS` variable for consistency
3. Always clean up with `rm -rf /var/lib/apt/lists/*`
4. Consider adding to preset combinations if appropriate
5. Update README.md with the new task documentation