#!/usr/bin/env bash

rm ~/.config/nwg-dock-hyprland/style.css
ln -s ~/.config/nwg-dock-hyprland/style-light.css ~/.config/nwg-dock-hyprland/style.css
~/.local/bin/nwg-dock-hyprland.sh
