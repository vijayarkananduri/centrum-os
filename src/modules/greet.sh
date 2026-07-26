#!/bin/bash

################################################################################
#
# GREET MODULE (ENHANCED)
# Advanced time-based greeting with context awareness
#
################################################################################

greet_main() {
    local user_name=$(config_get "USER_NAME" "User")
    local period=$(time_get_period)
    local greeting=$(time_get_greeting "$period" "$user_name")
    local date=$(date +"%A, %B %d, %Y")
    local time=$(date +"%H:%M %p")
    local yesterday_log=$(memory_yesterday)
    local project_count=$(echo "$yesterday_log" | grep -c "PROJECT_OPEN" || echo "0")
    local focus_time=$(echo "$yesterday_log" | grep "FOCUS_END" | grep -oP '\d+(?=_minutes)' | paste -sd+ | bc 2>/dev/null || echo "0")
    
    clear
    echo -e "\033[38;2;255;102;0m"
    echo "┌─────────────────────────────────────────┐"
    echo "│                                         │"
    echo "│      C E N T R U M   O S   v0.1        │"
    echo "│                                         │"
    echo "│      \"Return to focus.\"                 │"
    echo "│                                         │"
    echo "├─────────────────────────────────────────┤"
    printf "│  %-39s │\n" "$greeting"
    printf "│  %-39s │\n" "$date, $time"
    echo "│                                         │"
    printf "│  Yesterday: %d projects, %d min focus  │\n" "$project_count" "$focus_time"
    
    local agenda_count=$(grep -c "^- \[" ~/.centrum/memory/agenda.md 2>/dev/null || echo "0")
    local agenda_done=$(grep -c "^- \[x\]" ~/.centrum/memory/agenda.md 2>/dev/null || echo "0")
    printf "│  Today: %d tasks (%d done)              │\n" "$agenda_count" "$agenda_done"
    
    echo "│                                         │"
    echo "│  [w]ork [a]genda [f]ocus [s]tatus      │"
    echo "│  [y]esterday [n]ews [t]heme [h]elp    │"
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
    
    memory_log "SESSION_START" "greet" "period:$period"
}
