#!/usr/bin/env fish

# function ls --wraps lsd
#     lsd --all --icon=auto --group-directories-first $argv
# end

# function lst --wraps lsd
#     lsd --tree --color=auto $argv
# end

# function lsl --wraps lsd
#     lsd --all --icon=auto --group-directories-first --long \
#         --git --header $argv
# end

# function lslt --wraps lsd
#     lsd --tree --color=auto $argv
# end

function ls --wraps eza
    set newargs
    set used_t 0

    for arg in $argv
        if string match -- '-*t*' $arg
            # mark that -t was used
            set used_t 1
            # remove the 't' from combined flags
            set cleaned (string replace -- 't' '' $arg)
            if test "$cleaned" != "-"
                set newargs $newargs $cleaned
            end
        else
            set newargs $newargs $arg
        end
    end

    if test $used_t -eq 1
        eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -snew $newargs
    else
        eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first $newargs
    end
end

function la --wraps eza
    eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -a $argv
end

function ll --wraps eza
    eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -l --git -h $argv
end

function lla --wraps eza
    eza --color=auto --color-scale=all --color-scale-mode=gradient --icons=auto --group-directories-first -a -l --git -h $argv
end
