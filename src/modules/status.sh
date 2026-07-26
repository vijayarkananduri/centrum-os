#!/bin/bash

################################################################################
#
# STATUS MODULE (ENHANCED)
# Comprehensive system and productivity dashboard
#
################################################################################

status_main() {
    clear
    echo -e "\033[38;2;255;102;0m"
    echo "┌─────────────────────────────────────────┐"
    echo "│  SYSTEM STATUS & PRODUCTIVITY DASHBOARD │"
    echo "├─────────────────────────────────────────┤"
    
    # System info
    echo "│  SYSTEM                                 │"
    echo "│                                         │"
    
    local uptime=$(uptime -p 2>/dev/null || echo "Unknown")
    printf "│  Uptime: %-35s │\n" "$uptime"
    
    local hostname=$(hostname 2>/dev/null || echo "Unknown")
    printf "│  Host: %-37s │\n" "$hostname"
    
    local cpu=$(nproc 2>/dev/null || echo "?")
    printf "│  CPU cores: %-33s │\n" "$cpu"
    
    # Memory
    if command -v free &> /dev/null; then
        local mem=$(free -h 2>/dev/null | awk 'NR==2 {print $3 " / " $2}')
        printf "│  Memory: %-35s │\n" "$mem"
    fi
    
    # Disk
    if command -v df &> /dev/null; then
        local disk=$(df -h ~ 2>/dev/null | awk 'NR==2 {print $3 " / " $2}')
        printf "│  Disk: %-37s │\n" "$disk"
    fi
    
    echo "│                                         │"
    echo "│  TODAY'S ACTIVITY                       │"
    echo "│                                         │"
    
    local today_log=$(memory_today)
    local projects=$(echo "$today_log" | grep -c "PROJECT_OPEN" || echo "0")
    local focus_sessions=$(echo "$today_log" | grep -c "FOCUS_START" || echo "0")
    local total_focus=$(echo "$today_log" | grep "FOCUS_END" | grep -oP '\d+(?=_minutes)' | paste -sd+ | bc 2>/dev/null || echo "0")
    local notes=$(echo "$today_log" | grep -c "NOTE_SAVE" || echo "0")
    local agenda_done=$(echo "$today_log" | grep -c "AGENDA_DONE" || echo "0")
    
    printf "│  Projects: %-34s │\n" "$projects"
    printf "│  Focus sessions: %-27s │\n" "$focus_sessions"
    printf "│  Focus time: %-32s │\n" "${total_focus} min"
    printf "│  Tasks completed: %-26s │\n" "$agenda_done"
    printf "│  Notes saved: %-30s │\n" "$notes"
    
    echo "│                                         │"
    echo "│  QUICK ACTIONS                         │"
    echo "│  [w]ork [f]ocus [a]genda [n]ews       │"
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
}
