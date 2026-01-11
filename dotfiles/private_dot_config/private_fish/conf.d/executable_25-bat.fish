#!/usr/bin/env fish

# Check if `bat' is installed in /usr/bin or /opt/homebrew/bin
if test \( -e /usr/bin/bat \) -o \( -e /opt/homebrew/bin/bat \)
    # Use deltas for bat --diff
    set -gx BATDIFF_USE_DELTA true
    # Colorize manpages using bat
    set -q MANPAGER; or set -Ux MANPAGER 'sh -c "col -bx | bat --language=man --style=grid --color=always --decorations=always"'
    set -q MANROFFOPT; or set -Ux MANROFFOPT -c
    # Use bat as a replacement for `cat'
    function cat --wraps bat
        bat --paging=never --style plain $argv
    end

    # Use bat as a replacement for `less'
    function less --wraps bat
        bat --paging=always --style plain $argv
    end

end
