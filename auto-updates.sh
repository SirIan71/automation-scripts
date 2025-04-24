#!/bin/bash

# Auto-update script for Linux systems (Ubuntu/CentOS)
LOG_FILE="/var/log/auto_updates.log"

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "Error: OS not detected." >> "$LOG_FILE"
    exit 1
fi

# Update packages based on OS
echo "$(date) - Starting updates..." >> "$LOG_FILE"
if [ "$OS" = "ubuntu" ]; then
    apt-get update -y >> "$LOG_FILE" 2>&1
    unattended-upgrade -v >> "$LOG_FILE" 2>&1
elif [ "$OS" = "centos" ]; then
    yum update -y --security >> "$LOG_FILE" 2>&1
else
    echo "Unsupported OS: $OS" >> "$LOG_FILE"
    exit 1
fi

echo "$(date) - Updates completed successfully." >> "$LOG_FILE"