#!/usr/bin/env bash

gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"   # for GTK3 apps
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"   # for GTK4 apps

gsettings set org.gnome.meld prefer-dark-theme  true
gsettings set com.github.wwmm.easyeffects use-dark-theme true