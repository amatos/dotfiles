#!/bin/bash
IMAGE=$HOME/Pictures/background.png
# Use the result of 'darkman get' to determine whether
# to create a light or dark color scheme.
# n.b.: default to dark
if [ `darkman get` == "light" ]; then
	LIGHT="-l"
else
	LIGHT=""
fi
# Clear wal cache
wal -c
# Generate a new color scheme
wal -i "$IMAGE" $LIGHT
# Apply the color scheme
swaync-client --reload-css
cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
pywalfox update
pywal_sublime.sh
