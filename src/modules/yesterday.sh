#!/bin/bash

################################################################################
#
# YESTERDAY MODULE (ENHANCED)
# Comprehensive previous day activity analysis
#
################################################################################

yesterday_main() {
    local yesterday_log=$(memory_yesterday)
    
    if [[ -z "$yesterday_log" ]]; then
        echo "No activity from yesterday."
        return
    fi
    
    clear
    echo -e "\033[38;2;255;102;0m"
    echo "┌─────────────────────────────────────────┐"
    echo "│  YESTERDAY'S ACTIVITY REPORT             │"
    echo "├─────────────────────────────────────────┤"
    
    # Count statistics
    local project_count=$(echo "$yesterday_log" | grep -c "PROJECT_OPEN" || echo "0")
    local focus_sessions=$(echo "$yesterday_log" | grep -c "FOCUS_START" || echo "0")
    local notes=$(echo "$yesterday_log" | grep -c "NOTE_SAVE" || echo "0")
    local agenda_done=$(echo "$yesterday_log" | grep -c "AGENDA_DONE" || echo "0")
    local total_focus=$(echo "$yesterday_log" | grep "FOCUS_END" | grep -oP '\d+(?=_minutes)' | paste -sd+ | bc 2>/dev/null || echo "0")
    
    printf "│  Projects opened: %-26s │\n" "$project_count"
    printf "│  Focus sessions: %-27s │\n" "$focus_sessions"
    printf "│  Total focus time: %-25s │\n" "${total_focus} minutes"
    printf "│  Tasks completed: %-26s │\n" "$agenda_done"
    printf "│  Notes saved: %-30s │\n" "$notes"
    
    echo "│                                         │"
    echo "│  Activity Timeline:                    │"
    echo "│                                         │"
    
    echo "$yesterday_log" | head -20 | while read -r line; do
        local timestamp=$(echo "$line" | cut -d'|' -f1 | cut -d'T' -f2 | cut -d'+' -f1 | cut -c1-5)
        local category=$(echo "$line" | cut -d'|' -f2)
        local desc=$(echo "$line" | cut -d'|' -f3 | cut -c1-20)
        printf "│  %s %-15s %-19s │\n" "$timestamp" "$category" "$desc"
    done
    
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
}
