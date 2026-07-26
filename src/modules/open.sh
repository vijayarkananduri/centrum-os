#!/bin/bash

################################################################################
#
# OPEN MODULE (ENHANCED)
# Fuzzy file/project opener with intelligent matching
#
################################################################################

open_main() {
    local search_term="${1:-}"
    
    if [[ -z "$search_term" ]]; then
        echo "Recent projects:"
        tail -5 ~/.centrum/memory/projects.index 2>/dev/null | while read -r line; do
            local path=$(echo "$line" | cut -d'|' -f1)
            printf "  • %s\n" "$(basename "$path")"
        done
        return
    fi
    
    local project_paths=$(config_get 'PROJECT_PATHS' "$HOME/projects")
    local matches=()
    local i=0
    
    # Search for projects matching the term
    for base_path in $(echo "$project_paths" | tr ':' '\n'); do
        if [[ -d "$base_path" ]]; then
            for dir in "$base_path"/*; do
                if [[ -d "$dir" ]]; then
                    local dir_name=$(basename "$dir")
                    if echo "$dir_name" | grep -qi "$search_term"; then
                        matches+=("$dir")
                        ((i++))
                    fi
                fi
            done
        fi
    done
    
    if [[ ${#matches[@]} -eq 0 ]]; then
        echo "No matches for '$search_term'"
        return 1
    elif [[ ${#matches[@]} -eq 1 ]]; then
        local selected="${matches[0]}"
        echo "Opening: $(basename "$selected")"
        memory_log "PROJECT_OPEN" "$(basename "$selected")" "path:$selected"
        cd "$selected"
        memory_add_project "$selected" "0" "active"
    else
        echo "Multiple matches found:"
        for i in "${!matches[@]}"; do
            printf "  [%d] %s\n" "$((i+1))" "$(basename "${matches[$i]}")"
        done
        read -p "Select project (number): " selection
        if [[ $selection =~ ^[0-9]+$ ]] && (( selection > 0 && selection <= ${#matches[@]} )); then
            local selected="${matches[$((selection-1))]}"
            echo "Opening: $(basename "$selected")"
            memory_log "PROJECT_OPEN" "$(basename "$selected")" "path:$selected"
            cd "$selected"
            memory_add_project "$selected" "0" "active"
        fi
    fi
}
