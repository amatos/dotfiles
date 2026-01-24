#!/usr/bin/env fish

# Enable brew-wrap from brew-file
# https://homebrew-file.readthedocs.io/en/latest/brew-wrap.html
if test -f (brew --prefix)/etc/brew-wrap.fish
  source (brew --prefix)/etc/brew-wrap.fish
end
