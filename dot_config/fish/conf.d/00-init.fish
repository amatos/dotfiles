#!/usr/bin/env fish

# Base path.
set -Ux fish_user_paths "$HOME/.local/bin"

# Config files.
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_STATE_HOME "$HOME/.local/state"

# Machine info.
set -gx OS "$(uname)"

if command -v hostnamectl &>/dev/null
    set -gx HOST "$(hostnamectl --static)"
else if command -v scutil &>/dev/null # macOS
    set -gx HOST "$(scutil --get ComputerName)"
end

# Projects dir.
set -gx HACK "$HOME/hackin"

# Editor.
set -gx EDITOR nvim
set -gx VISUAL "subl -w "
set -gx SUDO_EDITOR "$EDITOR"

# Use vi key bindings.
#set -g fish_key_bindings fish_vi_key_bindings
