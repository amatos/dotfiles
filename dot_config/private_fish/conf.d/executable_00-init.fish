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

# Editor.
if test \( -e /usr/bin/nvim \) -o \( -e /opt/homebrew/bin/nvim \)
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

# If zed is installed, set zed as my visual editor, otherwise
# If BBEdit is installed, use BBEdit

if [ -e "/opt/homebrew/bin/zed -w" ]
    set -gx VISUAL "/opt/homebrew/bin/zed -w "
else if [ -e "/usr/bin/zed -w" ]
    set -gx VISUAL "/usr/bin/zed -w "
else if [ -e /opt/homebrew/bin/bbedit ]
    set -gx VISUAL "/opt/homebrew/bin/bbedit --wait "
end

set -gx SUDO_EDITOR "$EDITOR"

# Use vi key bindings.
#set -g fish_key_bindings fish_vi_key_bindings
