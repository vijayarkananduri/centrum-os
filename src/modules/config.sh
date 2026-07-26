#!/bin/bash

################################################################################
#
# CONFIG MODULE
# User preference management
#
################################################################################

config_main() {
    local key="${1:-}"
    local value="${2:-}"
    
    if [[ -z "$key" ]]; then
        echo "Current configuration:"
        cat ~/.centrum/config/centrum.conf
    elif [[ -z "$value" ]]; then
        echo "Value of $key: $(config_get "$key")"
    else
        config_set "$key" "$value"
        echo "Set $key = $value"
        memory_log "CONFIG_CHANGE" "$key=$value" "user_initiated"
    fi
}
