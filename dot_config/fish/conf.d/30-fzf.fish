#!/usr/bin/env fish

set -gx FZF_DEFAULT_CMD 'rg --files --hidden --glob "!.git"'

set -gx FZF_DEFAULT_OPTS "\
    --margin=10%,5% \
    --border=sharp \
    --pointer=' ' \
    --marker=' ' \
    --prompt=' ' \
    --preview-label-pos='bottom' \
    --preview-window='border-sharp' "

# fzf.fish
set -g fzf_preview_dir_cmd eza --all --color=always --sort=name --group-directories-first
set -g fzf_diff_highlighter delta --paging=never --features=arctic-fox
