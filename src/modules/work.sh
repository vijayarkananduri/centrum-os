#!/bin/bash

################################################################################
#
# WORK MODULE
# Open and track project work
#
################################################################################

work_main() {
    local project_name="${1:-}"
    
    if [[ -z "$project_name" ]]; then
        echo "Recent projects:"
        tail -5 ~/.centrum/memory/projects.index 2>/dev/null | while read -r line; do
            local path=$(echo "$line" | cut -d'|' -f1)
            local last_date=$(echo "$line" | cut -d'|' -f2)
            local last_time=$(echo "$line" | cut -d'|' -f3)
            local duration=$(echo "$line" | cut -d'|' -f4)
            
            printf "  • $(basename "$path") — %s at %s (%d min)\n" "$last_date" "$last_time" "$duration"
        done
        return
    fi
    
    local project_paths=$(config_get 'PROJECT_PATHS' "$HOME/projects")
    local found_project=""
    
    for base_path in $(echo "$project_paths" | tr ':' '\n'); do
        if [[ -d "$base_path/$project_name" ]]; then
            found_project="$base_path/$project_name"
            break
        fi
    done
    
    if [[ -n "$found_project" ]]; then
        echo "Opening $project_name..."
        memory_log "PROJECT_OPEN" "$project_name" "path:$found_project"
        cd "$found_project"
        echo "Entered: $found_project"
    else
        echo "Project not found: $project_name"
        return 1
    fi
}
