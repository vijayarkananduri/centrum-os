#!/bin/bash

################################################################################
#
# CONFIG LIBRARY
# Configuration file management
#
################################################################################

CONFIG_FILE="${HOME}/.centrum/config/centrum.conf"

################################################################################
# Initialize config file
################################################################################

config_init() {
    mkdir -p "$(dirname "$CONFIG_FILE")"
    
    if [[ ! -f "$CONFIG_FILE" ]]; then
        cat > "$CONFIG_FILE" << 'EOF'
# Centrum OS Configuration
# Edit this file to customize your experience

# User
USER_NAME="User"
USER_EMAIL=""

# Paths
PROJECT_PATHS="$HOME/projects:$HOME/work"
EDITOR="nvim"
BROWSER="w3m"

# Behavior
AUTO_GREET="true"
THEME_AUTO="true"
FOCUS_BLOCK_DISTRACTIONS="false"
NEWS_DEFAULT_SOURCE="hackernews"

# Time
WORK_DAY_START="08:00"
WORK_DAY_END="18:00"
FOCUS_DEFAULT_MINUTES="45"
EOF
    fi
}

################################################################################
# Get config value
################################################################################

config_get() {
    local key="$1"
    local default="${2:-}"
    
    if [[ -f "$CONFIG_FILE" ]]; then
        grep "^${key}=" "$CONFIG_FILE" 2>/dev/null | cut -d= -f2- | tr -d '\"' || echo "$default"
    else
        echo "$default"
    fi
}

################################################################################
# Set config value
################################################################################

config_set() {
    local key="$1"
    local value="$2"
    
    config_init
    
    if grep -q "^${key}=" "$CONFIG_FILE"; then
        sed -i "s|^${key}=.*|${key}=\"${value}\"|" "$CONFIG_FILE"
    else
        echo "${key}=\"${value}\"" >> "$CONFIG_FILE"
    fi
}

config_init
