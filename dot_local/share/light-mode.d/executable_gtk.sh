#!/usr/bin/env bash
gnome_schema="org.gnome.desktop.interface"

gsettings set "$gnome_schema" color-scheme "default"   # for GTK4 apps
gsettings set "$gnome_schema" cursor-theme "Adwaita"
gsettings set "$gnome_schema" font-name "Adwaita Sans 12"
gsettings set "$gnome_schema" gtk-theme "Adwaita"   # for GTK3 apps
gsettings set com.github.wwmm.easyeffects use-dark-theme false
gsettings set org.gnome.meld prefer-dark-theme  false
