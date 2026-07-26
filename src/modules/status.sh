#!/bin/bash

################################################################################
#
# STATUS MODULE
# Display system health and user statistics
#
################################################################################

status_main() {
    echo -e "\033[38;2;255;102;0m"
    echo "┌─────────────────────────────────────────┐"
    echo "│  SYSTEM STATUS                          │"
    echo "├─────────────────────────────────────────┤"
    
    local uptime=$(uptime -p 2>/dev/null || echo "Unknown")
    printf "│  Uptime: %-33s │\n" "$uptime"
    
    local mem=$(free -h | awk 'NR==2 {print $3 " / " $2}' 2>/dev/null || echo "N/A")
    printf "│  Memory: %-33s │\n" "$mem"
    
    local disk=$(df -h ~ | awk 'NR==2 {print $3 " / " $2}' 2>/dev/null || echo "N/A")
    printf "│  Disk: %-35s │\n" "$disk"
    
    echo "│                                         │"
    echo "│  TODAY'S ACTIVITY                       │"
    echo "│                                         │"
    
    local today_log=$(memory_today)
    local projects=$(echo "$today_log" | grep -c "PROJECT_OPEN" || echo "0")
    local focus_min=$(echo "$today_log" | grep "FOCUS_END" | awk -F'|' '{sum += $3} END {print sum}' || echo "0")
    
    printf "│  Projects worked on: %-21s │\n" "$projects"
    printf "│  Focus time: %-33s │\n" "${focus_min} minutes"
    
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
}
