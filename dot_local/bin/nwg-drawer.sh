#!/usr/bin/env bash

nwg-drawer -r -fm nautilus -ovl -term kitty -wm hyprland -pbexit "~/.config/hypr/scripts/graceKills.sh logout" -pblock hyprlock -pbpoweroff "~/.config/hypr/scripts/graceKills.sh shutdown" -pbreboot "~/.config/hypr/scripts/graceKills.sh reboot" -pbsleep "hyprlock && systemctl suspend"
