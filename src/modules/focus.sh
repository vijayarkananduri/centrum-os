#!/bin/bash

################################################################################
#
# FOCUS MODULE (ENHANCED)
# Advanced timed focus sessions with progress tracking
#
################################################################################

focus_main() {
    local minutes="${1:-45}"
    local project="${2:-General}"
    
    # Validate input
    if ! [[ "$minutes" =~ ^[0-9]+$ ]] || (( minutes < 1 )); then
        echo "Invalid time duration. Use: centrum focus [minutes] [project-name]"
        return 1
    fi
    
    clear
    echo -e "\033[38;2;0;255;65m"
    echo "┌─────────────────────────────────────────┐"
    echo "│                                         │"
    echo "│           F O C U S   M O D E          │"
    echo "│                                         │"
    echo "├─────────────────────────────────────────┤"
    printf "│  Project: %-35s │\n" "$project"
    echo "│                                         │"
    
    memory_log "FOCUS_START" "${minutes}_minutes" "project:$project"
    
    local seconds=$((minutes * 60))
    local start_time=$(date +%s)
    
    while (( seconds > 0 )); do
        local mins=$((seconds / 60))
        local secs=$((seconds % 60))
        local elapsed=$(($(date +%s) - start_time))
        local progress=$((100 * elapsed / (minutes * 60)))
        local bar_filled=$((progress / 5))
        local bar_empty=$((20 - bar_filled))
        local progress_bar=$(printf '%*s' "$bar_filled" | tr ' ' '=')
        local progress_empty=$(printf '%*s' "$bar_empty" | tr ' ' '-')
        
        printf "│  Time: %02d:%02d  [%s%s] %3d%%  │\r" "$mins" "$secs" "$progress_bar" "$progress_empty" "$progress"
        
        sleep 1
        ((seconds--))
    done
    
    echo "│  Time: 00:00  [====================] 100%%  │"
    echo "│                                         │"
    echo "│       ✓ Focus session complete!        │"
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
    
    memory_log "FOCUS_END" "${minutes}_minutes" "status:completed|project:$project"
    memory_add_project "$project" "$minutes" "active"
}
