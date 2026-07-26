#!/bin/bash

################################################################################
#
# SAVE MODULE
# Quick note saving
#
################################################################################

save_main() {
    local note="$@"
    
    if [[ -n "$note" ]]; then
        memory_save_note "$note"
        echo "Note saved: $note"
        memory_log "NOTE_SAVE" "$note" "time:$(date +%H:%M)"
    else
        echo "Usage: centrum save \"Your note here\""
    fi
}
