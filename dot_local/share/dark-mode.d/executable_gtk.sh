#!/usr/bin/env bash
gnome_schema="org.gnome.desktop.interface"

gsettings set "$gnome_schema" gtk-theme "Adwaita-dark"   # for GTK3 apps
gsettings set "$gnome_schema" color-scheme "prefer-dark"   # for GTK4 apps
# gsettings set "$gnome_schema" gtk-theme "catppuccin-macchiato-mauve"
gsettings set "$gnome_schema" font-name "SF Pro Display 12"
gsettings set "$gnome_schema" cursor-theme "Bibata Classic Ice"
gsettings set "$gnome_schema" color-scheme prefer-dark
gsettings set org.gnome.meld prefer-dark-theme  true
gsettings set com.github.wwmm.easyeffects use-dark-theme true
