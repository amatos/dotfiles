#!/usr/bin/env fish

function ls --wraps lsd
    lsd --all --icon=auto --sort=none --group-directories-first $argv
end

function lst --wraps lsd
    ls --tree --color=always $argv
end

function lsl --wraps lsd
    lsd --all --icon=auto --sort=none --group-directories-first --grid --long \
        --git --header $argv
end

function lslt --wraps lsd
    lsl --tree --color=always $argv
end
