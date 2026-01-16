#!/usr/bin/env fish

# Set preferred terminal editor based on the following preference hierarchy:
# 1. hx     (helix)
# 2. nvim   (neovim)
# 3. vim

if [ -e /opt/homebrew/bin/hx ]
    set -gx EDITOR hx
else if [ -e /usr/bin/nvim ] -o [ -e /opt/homebrew/bin/nvim ]
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

set -gx SUDO_EDITOR "$EDITOR"
