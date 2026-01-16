#!/usr/bin/env fish

# Base path.
set -Ux fish_user_paths "$HOME/.local/bin"

# Machine info.
set -gx OS "$(uname)"

if command -v hostnamectl &>/dev/null
    set -gx HOST "$(hostnamectl --static)"
else if command -v scutil &>/dev/null # macOS
    set -gx HOST "$(scutil --get ComputerName)"
end

# Use vi key bindings.
#set -g fish_key_bindings fish_vi_key_bindings
