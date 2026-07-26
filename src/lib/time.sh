#!/bin/bash

################################################################################
#
# TIME LIBRARY
# Time and date utilities
#
################################################################################

################################################################################
# Get time of day
################################################################################

time_get_period() {
    local hour=$(date +%H)
    
    if (( hour >= 5 && hour < 8 )); then
        echo "dawn"
    elif (( hour >= 8 && hour < 12 )); then
        echo "morning"
    elif (( hour >= 12 && hour < 17 )); then
        echo "afternoon"
    elif (( hour >= 17 && hour < 22 )); then
        echo "evening"
    else
        echo "night"
    fi
}

################################################################################
# Get greeting for period
################################################################################

time_get_greeting() {
    local period="$1"
    local name="${2:-User}"
    
    case "$period" in
        dawn)
            echo "Good morning, $name. (Early riser!)"
            ;;
        morning)
            echo "Good morning, $name."
            ;;
        afternoon)
            echo "Good afternoon, $name."
            ;;
        evening)
            echo "Good evening, $name."
            ;;
        night)
            echo "Working late, $name?"
            ;;
        *)
            echo "Hello, $name."
            ;;
    esac
}

################################################################################
# Format time
################################################################################

time_format() {
    date +"%Y-%m-%d %H:%M:%S"
}

################################################################################
# Get day of week
################################################################################

time_get_day() {
    date +"%A"
}

################################################################################
# Check if work hours
################################################################################

time_is_work_hours() {
    local hour=$(date +%H)
    (( hour >= 8 && hour < 18 )) && return 0 || return 1
}
