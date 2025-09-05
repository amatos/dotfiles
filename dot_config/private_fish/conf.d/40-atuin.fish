#!/usr/bin/env fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    if [ -e /opt/homebrew/bin/atuin ]
      atuin init --disable-up-arrow fish | source
    end
end
