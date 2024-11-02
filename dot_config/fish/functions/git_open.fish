#!/usr/bin/env fish

function git_open
    set -f origin "$(git remote get-url origin)"

    switch "$origin"
        case "*github*"
            if command -v gh &>/dev/null
                gh repo view --web &>/dev/null
            else if command -v hub &>/dev/null
                hub browse &>/dev/null
            else
                set_color red
                echo "[ERROR] Install gh-cli or hub to open Github repos." >&2
                set_color normal
                return 1
            end
        case "https://*"
            open '$origin' >/dev/null &
        case "*"
            set_color red
            printf "[ERROR] Unrecognized origin %s" "$origin" >&2
            return 1
    end
end
