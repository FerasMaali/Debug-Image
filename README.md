# Debug Image

A lightweight Ubuntu-based Docker image with essential debugging tools and on-demand installation capabilities.

## Quick Start

```bash
# Pull and run the image
docker run -it --rm ferasmaali/dbg

# With network host access
docker run -it --rm --network host ferasmaali/dbg

# With volume mount
docker run -it --rm -v $(pwd):/workspace ferasmaali/dbg
```

## Base Image

The base image (~150MB) includes:
- Ubuntu 24.04
- BusyBox utilities
- Git, Vim, Wget
- Curl with CA certificates
- Moreutils (additional Unix utilities)
- Taskfile (go-task) for on-demand installations
- Bash completion for task commands

## On-Demand Installation

Use `task` to install additional tools as needed:

```bash
# List all available tasks (or just run 'task')
task --list

# Install specific tool sets
task network       # Network tools (nmap, tcpdump, netcat, etc.)
task python        # Python 3 and pip
task build-tools   # Build essentials (gcc, make, etc.)
task monitoring    # System monitoring (htop, iotop, iftop)
task dev           # Development setup (python, build-tools, asdf)

# Terminal utilities
task tmux          # Terminal multiplexer
task jq            # JSON processor

# Database tools
task azure-cli     # Azure CLI
task mssql         # MS SQL Server tools (sqlcmd, bcp, sqlpackage)
task mongodb       # MongoDB shell (mongosh)

# Install everything (recreate full image)
task full
```

## Available Tasks

| Task | Description | Tools Installed |
|------|-------------|-----------------|
| `python` | Python development | python3, pip |
| `build-tools` | Compilation tools | build-essential |
| `asdf` | Version manager | asdf |
| `network` | Network debugging | ping, nmap, tcpdump, netcat, traceroute, telnet, etc. |
| `monitoring` | System monitoring | htop, iotop, iftop |
| `archive` | Archive tools | zip, unzip, rar, unrar, gzip, xz |
| `enhanced-vim` | Vim configuration | amix/vimrc |
| `tmux` | Terminal multiplexer | tmux |
| `jq` | JSON processor | jq |
| `azure-cli` | Azure tools | az cli |
| `mssql` | SQL Server tools | sqlcmd, bcp, sqlpackage |
| `mongodb` | MongoDB tools | mongosh |
| `debug-tools` | Debugging | gdb, strace |
| `dev` | Dev combo | python, build-tools, asdf |
| `full` | Everything | All of the above |

## Building Locally

```bash
docker build -t dbg .
```

## Versioning

New versions are created using the `push-version` script:

```bash
./push-version
```

This automatically increments the version number and pushes a new tag.