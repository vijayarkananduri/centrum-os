#!/bin/bash

################################################################################
#
# THEME MODULE (ENHANCED)
# Advanced terminal color scheme management
#
################################################################################

theme_main() {
    local theme="${1:-auto}"
    
    case "$theme" in
        day)
            apply_theme "day"
            ;;
        night)
            apply_theme "night"
            ;;
        dawn)
            apply_theme "dawn"
            ;;
        dusk)
            apply_theme "dusk"
            ;;
        paper)
            apply_theme "paper"
            ;;
        auto)
            local period=$(time_get_period)
            case "$period" in
                dawn) apply_theme "dawn" ;;
                morning) apply_theme "day" ;;
                afternoon) apply_theme "day" ;;
                evening) apply_theme "dusk" ;;
                night) apply_theme "night" ;;
            esac
            ;;
        list)
            echo "Available themes:"
            echo "  day    - Bright, energetic (Orange on White)"
            echo "  night  - Dark, focused (Green on Black)"
            echo "  dawn   - Warm, gentle (Brown on Beige)"
            echo "  dusk   - Calm, winding down (Cyan on Dark Blue)"
            echo "  paper  - Reading/writing (Dark on Light Beige)"
            echo "  auto   - Switch based on time of day"
            ;;
        *)
            echo "Usage: centrum theme [day|night|dawn|dusk|paper|auto|list]"
            ;;
    esac
}

apply_theme() {
    local theme="$1"
    local theme_file="$HOME/.centrum/themes/${theme}.theme"
    
    if [[ ! -f "$theme_file" ]]; then
        # Create default theme if not exists
        create_default_theme "$theme"
        theme_file="$HOME/.centrum/themes/${theme}.theme"
    fi
    
    # Source the theme file for any bash variables
    source "$theme_file" 2>/dev/null || true
    
    echo "Switched to $theme theme"
    memory_log "THEME_CHANGE" "$theme" "manual"
}

create_default_theme() {
    local theme="$1"
    local theme_file="$HOME/.centrum/themes/${theme}.theme"
    
    case "$theme" in
        day)
            cat > "$theme_file" << 'EOF'
# Day Theme - Bright and energetic
export THEME_PRIMARY="\033[38;2;255;102;0m"      # Orange
export THEME_SECONDARY="\033[38;2;51;51;51m"    # Dark Gray
export THEME_BG="\033[48;2;255;255;255m"        # White
export THEME_FG="\033[38;2;0;0;0m"              # Black
export THEME_RESET="\033[0m"
EOF
            ;;
        night)
            cat > "$theme_file" << 'EOF'
# Night Theme - Dark and focused
export THEME_PRIMARY="\033[38;2;0;255;65m"      # Green
export THEME_SECONDARY="\033[38;2;0;136;255m"  # Blue
export THEME_BG="\033[48;2;10;10;10m"          # Black
export THEME_FG="\033[38;2;200;200;200m"       # Light Gray
export THEME_RESET="\033[0m"
EOF
            ;;
        dawn)
            cat > "$theme_file" << 'EOF'
# Dawn Theme - Warm and gentle
export THEME_PRIMARY="\033[38;2;210;105;30m"   # Chocolate
export THEME_SECONDARY="\033[38;2;139;69;19m" # Brown
export THEME_BG="\033[48;2;245;245;220m"       # Beige
export THEME_FG="\033[38;2;101;67;33m"         # Dark brown
export THEME_RESET="\033[0m"
EOF
            ;;
        dusk)
            cat > "$theme_file" << 'EOF'
# Dusk Theme - Calm and winding down
export THEME_PRIMARY="\033[38;2;0;206;209m"    # Dark Turquoise
export THEME_SECONDARY="\033[38;2;147;112;219m" # Medium Purple
export THEME_BG="\033[48;2;25;25;112m"         # Midnight Blue
export THEME_FG="\033[38;2;176;196;222m"       # Light Steel Blue
export THEME_RESET="\033[0m"
EOF
            ;;
        paper)
            cat > "$theme_file" << 'EOF'
# Paper Theme - Clean reading/writing
export THEME_PRIMARY="\033[38;2;47;79;79m"    # Dark Slate Gray
export THEME_SECONDARY="\033[38;2;105;105;105m" # Dim Gray
export THEME_BG="\033[48;2;250;240;230m"       # Floral White
export THEME_FG="\033[38;2;0;0;0m"             # Black
export THEME_RESET="\033[0m"
EOF
            ;;
    esac
}
