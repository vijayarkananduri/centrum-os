#!/bin/bash

################################################################################
#
# FOCUS MODULE
# Timed focus sessions with distraction blocking
#
################################################################################

focus_main() {
    local minutes="${1:-45}"
    local project="${2:-}"
    
    echo "Starting focus mode for $minutes minutes..."
    
    if [[ -n "$project" ]]; then
        memory_log "FOCUS_START" "${minutes}_minutes" "project:$project"
    else
        memory_log "FOCUS_START" "${minutes}_minutes" "project:general"
    fi
    
    local seconds=$((minutes * 60))
    
    while (( seconds > 0 )); do
        local mins=$((seconds / 60))
        local secs=$((seconds % 60))
        printf "\rTime remaining: %02d:%02d" $mins $secs
        sleep 1
        ((seconds--))
    done
    
    echo -e "\nFocus session complete!"
    memory_log "FOCUS_END" "${minutes}_minutes" "status:completed"
}
