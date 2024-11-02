#!/usr/bin/env fish

function ls --wraps eza
    eza --all --icons=auto --sort=name --group-directories-first $argv
end

function lst --wraps eza
    ls --tree --color=always $argv
end

function lsl --wraps eza
    eza --all --icons=auto --sort=name --group-directories-first --grid --long \
        --git --header $argv
end

function lslt --wraps eza
    lsl --tree --color=always $argv
end
