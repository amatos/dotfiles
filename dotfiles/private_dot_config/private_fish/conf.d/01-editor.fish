#!/usr/bin/env fish

# Set preferred terminal editor based on the following preference hierarchy:
# 1. nvim   (neovim)
# 3. vim

if test -e /usr/bin/nvim || test -e /opt/homebrew/bin/nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end

set -gx SUDO_EDITOR "$EDITOR"
