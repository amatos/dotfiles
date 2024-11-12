#!/usr/bin/env bash

if [[ $1 == "light" ]]; then
	ags -r "useTheme('$HOME/.config/ags/themes/catppuccin_latte_split.json')"
elif [[ $1 == "dark" ]]; then
	ags -r "useTheme('$HOME/.config/ags/themes/catppuccin_macchiato_split.json')"
fi
exit 0
