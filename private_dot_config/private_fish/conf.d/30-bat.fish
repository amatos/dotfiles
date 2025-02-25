#!/usr/bin/env fish

if [ -e /usr/bin/bat ]
    set -gx BATDIFF_USE_DELTA true
    function cat --wraps bat
        bat --paging=never --style plain $argv
    end
    abbr -a B --position anywhere --set-cursor "% | bat"
    #    abbr -a --position anywhere -- -h "-h 2>&1 | bat --plain --language=help"
end

