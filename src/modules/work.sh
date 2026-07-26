#!/bin/bash

################################################################################
#
# WORK MODULE (ENHANCED)
# Full project management and navigation
#
################################################################################

work_main() {
    local project_name="${1:-}"
    local action="${2:-}"
    
    if [[ -z "$project_name" ]]; then
        show_recent_projects
        return
    fi
    
    # Search for project
    local project_paths=$(config_get 'PROJECT_PATHS' "$HOME/projects")
    local found_project=""
    
    # Try exact match first
    for base_path in $(echo "$project_paths" | tr ':' '\n'); do
        if [[ -d "$base_path/$project_name" ]]; then
            found_project="$base_path/$project_name"
            break
        fi
    done
    
    # Try fuzzy match if exact not found
    if [[ -z "$found_project" ]]; then
        for base_path in $(echo "$project_paths" | tr ':' '\n'); do
            if [[ -d "$base_path" ]]; then
                local matches=$(find "$base_path" -maxdepth 1 -type d -name "*$project_name*" 2>/dev/null | head -1)
                if [[ -n "$matches" ]]; then
                    found_project="$matches"
                    break
                fi
            fi
        done
    fi
    
    if [[ -n "$found_project" ]]; then
        local proj_name=$(basename "$found_project")
        echo "Opening $proj_name..."
        memory_log "PROJECT_OPEN" "$proj_name" "path:$found_project"
        cd "$found_project" && memory_add_project "$found_project" "0" "active"
        echo "Entered: $found_project"
        
        # Show project files if requested
        if [[ "$action" == "list" ]] || [[ "$action" == "ls" ]]; then
            echo ""
            echo "Project files:"
            ls -la | head -20
        fi
    else
        echo "Project not found: $project_name"
        echo ""
        echo "Searching in paths:"
        for base_path in $(echo "$project_paths" | tr ':' '\n'); do
            if [[ -d "$base_path" ]]; then
                echo "  $base_path"
                ls "$base_path" 2>/dev/null | head -5 | sed 's/^/    - /'
            fi
        done
        return 1
    fi
}

show_recent_projects() {
    echo "Recent projects:"
    echo ""
    tail -10 ~/.centrum/memory/projects.index 2>/dev/null | tac | while read -r line; do
        if [[ -n "$line" ]]; then
            local path=$(echo "$line" | cut -d'|' -f1)
            local last_date=$(echo "$line" | cut -d'|' -f2)
            local last_time=$(echo "$line" | cut -d'|' -f3)
            local duration=$(echo "$line" | cut -d'|' -f4)
            local name=$(basename "$path")
            
            printf "  • %-25s @ %s %s (%d min)\n" "$name" "$last_date" "$last_time" "$duration"
        fi
    done
    
    echo ""
    echo "Usage: centrum work [project-name] [list]"
}
