#!/bin/bash

notes_main() {
    local notes_dir="${HOME}/.centrum/memory/notes"

    if [[ ! -d "$notes_dir" ]] || [[ -z "$(ls -A "$notes_dir" 2>/dev/null)" ]]; then
        echo "No saved notes found."
        return 0
    fi

    echo "┌─────────────────────────────────────────┐"
    echo "│            SAVED NOTES                  │"
    echo "└─────────────────────────────────────────┘"
    echo ""

    # Print all saved notes with timestamps/filenames
    for note_file in "$notes_dir"/*; do
        if [[ -f "$note_file" ]]; then
            echo "-------------------------------------------"
            echo "Note: $(basename "$note_file")"
            echo "-------------------------------------------"
            cat "$note_file"
            echo ""
        fi
    done
}
