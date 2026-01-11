#!/bin/sh
# Template script executed once at init by run_once_init.tmpl.
# chezmoi execute run_once* scripts if content after template execution has changed,
# meaning that template execution is ran on each `chezmoi apply`,

# atuin fish completions
atuin gen-completions --shell fish --out-dir ~/.config/fish/completions

# starship fish completions
starship completions fish > ~/.config/fish/completions/starship.fish

# chezmoi fish completions
chezmoi completion fish --output ~/.config/fish/completions/chezmoi.fish

# procs fish completions
procs --gen-completion-out fish > ~/.config/fish/completions/procs.fish

# git-delta fish completions
delta --generate-completion fish > ~/.config/fish/completions/delta.fish
