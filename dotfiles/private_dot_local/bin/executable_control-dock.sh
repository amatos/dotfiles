#!/usr/bin/env bash

# Function to toggle the dock
hide_dock() {
    osascript -e 'tell application "System Events" to tell dock preferences to set autohide to true'

}

show_dock() {
    osascript -e 'tell application "System Events" to tell dock preferences to set autohide to false'
}

# Main script
while getopts "hs" opt; do
    case $opt in
        h)
            hide_dock
            ;;
        s)
            show_dock
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            ;;
    esac
done

# Execute the script with the provided options
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-h] [-s]"
    echo "  -h: Hide the dock"
    echo "  -s: Show the dock"
    exit 1
fi
