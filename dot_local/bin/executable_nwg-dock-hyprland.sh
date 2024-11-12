#!/usr/bin/env bash

kill $(pidof nwg-dock-hyprland)
nwg-dock-hyprland -d -f -i 64 -iw "special:junks,-98" -x &
