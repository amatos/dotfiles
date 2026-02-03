function t
    # Restore stdin/stdout to the terminal (fish-safe equivalent)
    # exec </dev/tty
    # exec <&1

    set -l session (sesh list -t -c | fzf \
        --height 40% \
        --reverse \
        --border-label ' sesh ' \
        --border \
        --prompt '⚡  ')

    # If nothing selected, exit
    if test -z "$session"
        return
    end

    sesh connect $session
end
