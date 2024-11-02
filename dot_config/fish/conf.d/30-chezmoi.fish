#!/usr/bin/env fish

abbr -a cz --position command chezmoi
abbr -a czap --position command "chezmoi apply"
abbr -a cza --position command "chezmoi add"
abbr -a czc --position command "chezmoi cd"
abbr -a cze --position command "chezmoi edit"

abbr -a czcm --position command 'git c -m "$(chezmoi generate git-commit-message)"'
