#!/bin/bash

CONFIG="$HOME/.config/hypr/waybar/config.json"
STYLE="$HOME/.config/hypr/waybar/style.css"

waybar --log-level error --config ${CONFIG} --style ${STYLE}
