#!/bin/bash

################################################################################
#
# NEWS MODULE (ENHANCED)
# Fetch and display headlines from multiple sources
#
################################################################################

news_main() {
    local source="${1:-hackernews}"
    
    case "$source" in
        hackernews|hn)
            fetch_hackernews
            ;;
        lobsters)
            fetch_lobsters
            ;;
        list)
            echo "Available news sources:"
            echo "  hackernews (hn)  - Hacker News"
            echo "  lobsters         - Lobsters.rs"
            ;;
        *)
            echo "Unknown source: $source"
            echo "Use 'centrum news list' to see available sources"
            return 1
            ;;
    esac
}

fetch_hackernews() {
    echo "Fetching from Hacker News..."
    
    if ! command -v curl &> /dev/null; then
        echo "Error: curl is required for news fetching"
        return 1
    fi
    
    local url="https://news.ycombinator.com/rss"
    local temp_file=$(mktemp)
    
    if curl -s "$url" > "$temp_file" 2>/dev/null; then
        # Simple RSS parsing with grep/sed
        echo ""
        echo "Top 10 Stories:"
        echo "==============="
        grep -oP '(?<=<title>)[^<]+' "$temp_file" | tail -11 | head -10 | nl
        echo ""
        memory_log "NEWS_FETCH" "hackernews" "source:hn"
    else
        echo "Error: Could not fetch news"
        rm -f "$temp_file"
        return 1
    fi
    
    rm -f "$temp_file"
}

fetch_lobsters() {
    echo "Fetching from Lobsters..."
    
    if ! command -v curl &> /dev/null; then
        echo "Error: curl is required for news fetching"
        return 1
    fi
    
    local url="https://lobste.rs/rss"
    local temp_file=$(mktemp)
    
    if curl -s "$url" > "$temp_file" 2>/dev/null; then
        echo ""
        echo "Top 10 Stories:"
        echo "==============="
        grep -oP '(?<=<title>)[^<]+' "$temp_file" | tail -11 | head -10 | nl
        echo ""
        memory_log "NEWS_FETCH" "lobsters" "source:lobsters"
    else
        echo "Error: Could not fetch news"
        rm -f "$temp_file"
        return 1
    fi
    
    rm -f "$temp_file"
}
