#!/bin/bash

################################################################################
#
# AGENDA MODULE
# Daily task and goal management
#
################################################################################

agenda_main() {
    local subcommand="${1:-list}"
    shift || true
    
    case "$subcommand" in
        list)
            echo "Today's agenda:"
            cat ~/.centrum/memory/agenda.md
            ;;
        add)
            local task="$@"
            if [[ -n "$task" ]]; then
                memory_add_agenda "$task"
                echo "Added: $task"
                memory_log "AGENDA_ADD" "$task" "priority:normal"
            else
                echo "Usage: centrum agenda add \"Task description\""
            fi
            ;;
        done)
            local item_num="${1:-}"
            if [[ -n "$item_num" ]]; then
                memory_done_agenda "$((item_num + 2))"
                echo "Marked item #$item_num as done"
                memory_log "AGENDA_DONE" "Item #$item_num" "time:$(date +%H:%M)"
            else
                echo "Usage: centrum agenda done [number]"
            fi
            ;;
        *)
            echo "Usage: centrum agenda [list|add|done]"
            ;;
    esac
}
