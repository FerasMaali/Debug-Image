#!/bin/bash

cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                    Debug Container - Lightweight                 ║
╚══════════════════════════════════════════════════════════════════╝

This is a minimal debug container with on-demand tool installation.

Base tools available:
 • git, vim, wget, curl, busybox utilities, moreutils

Install additional tools using 'task':
 • task --list       Show all available tools
 • task network      Install network debugging tools  
 • task dev          Install development tools
 • task full         Install everything

Quick examples:
 $ task network      # Install nmap, tcpdump, etc.
 $ task python       # Install Python 3 and pip
 $ task mongodb      # Install MongoDB shell

For more info: https://github.com/ferasmaali/Debug-Image

EOF
