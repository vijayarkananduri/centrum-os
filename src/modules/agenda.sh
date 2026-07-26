#!/bin/bash

################################################################################
#
# AGENDA MODULE (ENHANCED)
# Full-featured daily task management
#
################################################################################

agenda_main() {
    local subcommand="${1:-list}"
    shift || true
    
    case "$subcommand" in
        list|show)
            show_agenda
            ;;
        add)
            add_task "$@"
            ;;
        done|complete)
            mark_done "$@"
            ;;
        remove|delete)
            remove_task "$@"
            ;;
        clear)
            clear_agenda
            ;;
        priority)
            set_priority "$@"
            ;;
        *)
            echo "Usage: centrum agenda [list|add|done|remove|clear|priority]"
            echo ""
            echo "Examples:"
            echo "  centrum agenda list                    # Show agenda"
            echo "  centrum agenda add \"Task description\"  # Add task"
            echo "  centrum agenda done 1                 # Mark task 1 complete"
            echo "  centrum agenda remove 2               # Remove task 2"
            ;;
    esac
}

show_agenda() {
    local agenda_file="$HOME/.centrum/memory/agenda.md"
    
    clear
    echo -e "\033[38;2;255;102;0m"
    echo "┌─────────────────────────────────────────┐"
    echo "│  TODAY'S AGENDA                          │"
    echo "├─────────────────────────────────────────┤"
    echo "│                                         │"
    
    local line_num=1
    local has_tasks=false
    
    while IFS= read -r line; do
        if [[ "$line" =~ ^-\ \[ ]]; then
            has_tasks=true
            local checkbox=$(echo "$line" | grep -oP '\[.\]')
            local task=$(echo "$line" | sed 's/^- \[.\] //')
            local status_icon=""
            
            if [[ "$checkbox" == "[x]" ]]; then
                status_icon="✓"
            else
                status_icon="☐"
            fi
            
            printf "│  [%d] %s %-32s │\n" "$line_num" "$status_icon" "${task:0:32}"
            ((line_num++))
        fi
    done < "$agenda_file"
    
    if [[ "$has_tasks" == false ]]; then
        echo "│  (no tasks yet)                         │"
    fi
    
    echo "│                                         │"
    echo "│  [a]dd [d]one [r]emove [c]lear         │"
    echo "│                                         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "\033[0m"
}

add_task() {
    local task="$@"
    local agenda_file="$HOME/.centrum/memory/agenda.md"
    
    if [[ -z "$task" ]]; then
        read -p "Enter task description: " task
    fi
    
    if [[ -n "$task" ]]; then
        echo "- [ ] $task" >> "$agenda_file"
        echo "Added: $task"
        memory_log "AGENDA_ADD" "$task" "priority:normal"
    fi
}

mark_done() {
    local task_num="$1"
    local agenda_file="$HOME/.centrum/memory/agenda.md"
    
    if [[ -z "$task_num" ]]; then
        read -p "Mark task done (number): " task_num
    fi
    
    if [[ "$task_num" =~ ^[0-9]+$ ]]; then
        # Find the nth task line and mark it done
        local current_task=0
        local temp_file=$(mktemp)
        
        while IFS= read -r line; do
            if [[ "$line" =~ ^-\ \[ ]]; then
                ((current_task++))
                if (( current_task == task_num )); then
                    line=$(echo "$line" | sed 's/\[ \]/[x]/')
                fi
            fi
            echo "$line" >> "$temp_file"
        done < "$agenda_file"
        
        mv "$temp_file" "$agenda_file"
        echo "Task $task_num marked as done."
        memory_log "AGENDA_DONE" "Task #$task_num" "time:$(date +%H:%M)"
    fi
}

remove_task() {
    local task_num="$1"
    local agenda_file="$HOME/.centrum/memory/agenda.md"
    
    if [[ -z "$task_num" ]]; then
        read -p "Remove task (number): " task_num
    fi
    
    if [[ "$task_num" =~ ^[0-9]+$ ]]; then
        local current_task=0
        local temp_file=$(mktemp)
        
        while IFS= read -r line; do
            if [[ "$line" =~ ^-\ \[ ]]; then
                ((current_task++))
                if (( current_task == task_num )); then
                    continue
                fi
            fi
            echo "$line" >> "$temp_file"
        done < "$agenda_file"
        
        mv "$temp_file" "$agenda_file"
        echo "Task $task_num removed."
    fi
}

clear_agenda() {
    local agenda_file="$HOME/.centrum/memory/agenda.md"
    local today=$(date +%Y-%m-%d)
    
    cp "$agenda_file" "$HOME/.centrum/memory/notes/${today}-agenda-archived.md"
    echo "# Agenda — $(date +%Y-%m-%d)" > "$agenda_file"
    echo "Agenda cleared and previous saved."
    memory_log "AGENDA_CLEAR" "cleared and archived" "date:$today"
}

set_priority() {
    echo "Priority setting - coming in future version"
}
