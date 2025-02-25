#!/usr/bin/env fish

# Local environment variables.
if test -e "$HOME/.local.env"
    source "~/.local.env"
end

# If interactive, start up Atuin and display system information
if status is-interactive
    atuin init --disable-up-arrow fish | source
    fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
end
