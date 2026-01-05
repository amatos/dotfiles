#!/usr/bin/env fish

function ls --wraps lsd
    lsd --all --icon=auto --group-directories-first $argv
end

function lst --wraps lsd
    lsd --tree --color=auto $argv
end

function lsl --wraps lsd
    lsd --all --icon=auto --group-directories-first --long \
        --git --header $argv
end

function lslt --wraps lsd
    lsd --tree --color=auto $argv
end

# function ls --wraps eza
#     eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first $argv
# end

# function la --wraps eza
#     eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -a $argv
# end

# function ll --wraps eza
#     eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -l --git -h $argv
# end

# function lla --wraps eza
#     eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -a -l --git -h $argv
# end
