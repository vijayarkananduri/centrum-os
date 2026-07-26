#!/bin/bash

################################################################################
#
# GREET MODULE
# Time-based greeting and daily overview
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
    printf "│  Yesterday: %d project(s) opened      │\n" "$project_count"
    local agenda_count=$(grep -c "^- \[" ~/.centrum/memory/agenda.md 2>/dev/null || echo "0")
    printf "│  Today: %d agenda item(s)             │\n" "$agenda_count"
    echo "│                                         │"
    echo "│  [work] [agenda] [focus] [status]      │"
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
    
    memory_log "SESSION_START" "greet" "period:$period"
}
