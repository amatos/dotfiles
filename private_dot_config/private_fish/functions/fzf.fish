#!/usr/bin/env fish

function fzf --wraps=fzf
    if set --query TMUX
        fzf-tmux -p 90%,95% $argv
    else
        command fzf $argv
    end
end
