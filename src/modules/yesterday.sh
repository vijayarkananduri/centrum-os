#!/bin/bash

################################################################################
#
# YESTERDAY MODULE
# Generate report of previous day's activity
#
################################################################################

yesterday_main() {
    local yesterday_log=$(memory_yesterday)
    
    if [[ -z "$yesterday_log" ]]; then
        echo "No activity from yesterday."
        return
    fi
    
    echo "Yesterday's Activity Report"
    echo "==========================="
    echo ""
    
    local project_count=$(echo "$yesterday_log" | grep -c "PROJECT_OPEN" || echo "0")
    echo "Projects opened: $project_count"
    
    local focus_sessions=$(echo "$yesterday_log" | grep -c "FOCUS_START" || echo "0")
    echo "Focus sessions: $focus_sessions"
    
    local files_edited=$(echo "$yesterday_log" | grep -c "FILE_EDIT" || echo "0")
    echo "Files edited: $files_edited"
    
    echo ""
    echo "Activity log:"
    echo "$yesterday_log"
}
