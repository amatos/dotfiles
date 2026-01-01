#!/usr/bin/env fish

# Check if `bat' is installed in /usr/bin or /opt/homebrew/bin
if test \( -e /usr/bin/bat \) -o \( -e /opt/homebrew/bin/bat \)
    # Use deltas for bat --diff
    set -gx BATDIFF_USE_DELTA true
    # Use bat as man pager
    set -gx MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

    # Use bat as a replacement for `cat'
    function cat --wraps bat
        bat --paging=never --style plain $argv
    end

    # Use bat as a replacement for `less'
    function less --wraps bat
        bat --paging=always --style plain $argv
    end

    # Use bat as a replacement for `man'
    function man --wraps bat
        bat --paging=always --style plain $argv
    end

end
