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

# Editor.
set -gx EDITOR nvim
set -gx VISUAL "subl -w "
set -gx SUDO_EDITOR "$EDITOR"
