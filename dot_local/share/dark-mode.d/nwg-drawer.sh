#!/usr/bin/env bash

rm ~/.config/nwg-drawer/drawer.css
ln -s ~/.config/nwg-drawer/drawer-dark.css ~/.config/nwg-drawer/drawer.css
~/.local/bin/nwg-drawer.sh
