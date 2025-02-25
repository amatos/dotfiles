#!/usr/bin/env fish

function fm --wraps=fzf -d "Use fzf as a simple file viewer"
    find . -type d | fzf --preview='eza --color=always -T {} | head -n 50'
end
