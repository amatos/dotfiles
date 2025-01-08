#!/bin/bash
IMAGE=$HOME/Pictures/background.png
if [ `darkman get` == "light" ]; then
	LIGHT="-l"
else
	LIGHT=""
fi
wal -c
wal -i "$IMAGE" $LIGHT
swaync-client --reload-css
cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
pywalfox update
pywal_sublime.sh
