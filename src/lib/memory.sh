#!/bin/bash

################################################################################
#
# MEMORY LIBRARY
# Handles reading and writing to the Centrum memory system
#
################################################################################

MEMORY_DIR="${HOME}/.centrum/memory"

################################################################################
# Initialize memory structure
################################################################################

memory_init() {
    mkdir -p "$MEMORY_DIR"/{notes}
    touch "$MEMORY_DIR"/today.log
    touch "$MEMORY_DIR"/projects.index
    [[ ! -f "$MEMORY_DIR"/agenda.md ]] && echo "# Agenda — $(date +%Y-%m-%d)" > "$MEMORY_DIR"/agenda.md
}

################################################################################
# Log activity to today.log
################################################################################

memory_log() {
    local category="$1"
    local description="$2"
    local metadata="${3:-}"
    
    local timestamp=$(date -Iseconds)
    local entry="${timestamp}|${category}|${description}|${metadata}"
    
    echo "$entry" >> "$MEMORY_DIR"/today.log
}

################################################################################
# Read today's log
################################################################################

memory_today() {
    cat "$MEMORY_DIR"/today.log
}

################################################################################
# Read yesterday's log
################################################################################

memory_yesterday() {
    cat "$MEMORY_DIR"/yesterday.log 2>/dev/null || echo ""
}

################################################################################
# Get last activity entry
################################################################################

memory_last_activity() {
    tail -1 "$MEMORY_DIR"/today.log 2>/dev/null || echo ""
}

################################################################################
# Get projects from index
################################################################################

memory_get_projects() {
    cat "$MEMORY_DIR"/projects.index 2>/dev/null || echo ""
}

################################################################################
# Add project to index
################################################################################

memory_add_project() {
    local path="$1"
    local date=$(date +%Y-%m-%d)
    local time=$(date +%H:%M)
    local duration="${2:-0}"
    local status="${3:-active}"
    
    local entry="${path}|${date}|${time}|${duration}|${status}"
    echo "$entry" >> "$MEMORY_DIR"/projects.index
}

################################################################################
# Rotate logs (called at midnight)
################################################################################

memory_rotate() {
    cp "$MEMORY_DIR"/today.log "$MEMORY_DIR"/yesterday.log
    echo "" > "$MEMORY_DIR"/today.log
    
    local today=$(date +%Y-%m-%d)
    cp "$MEMORY_DIR"/agenda.md "$MEMORY_DIR"/notes/"${today}"-agenda.md
    
    echo "# Agenda — $(date +%Y-%m-%d)" > "$MEMORY_DIR"/agenda.md
    
    memory_log "SESSION" "Log rotation at midnight" "automatic"
}

################################################################################
# Read agenda
################################################################################

memory_get_agenda() {
    cat "$MEMORY_DIR"/agenda.md 2>/dev/null || echo ""
}

################################################################################
# Add to agenda
################################################################################

memory_add_agenda() {
    local task="$1"
    echo "- [ ] $task" >> "$MEMORY_DIR"/agenda.md
}

################################################################################
# Mark agenda item as done
################################################################################

memory_done_agenda() {
    local line_num="$1"
    local agenda_file="$MEMORY_DIR"/agenda.md
    
    sed -i "${line_num}s/\[ \]/[x]/" "$agenda_file"
}

################################################################################
# Save daily note
################################################################################

memory_save_note() {
    local note="$1"
    local today=$(date +%Y-%m-%d)
    local timestamp=$(date +%H:%M)
    
    echo "[$timestamp] $note" >> "$MEMORY_DIR"/notes/"${today}".md
}

memory_init
