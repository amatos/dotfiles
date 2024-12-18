#!/usr/bin/env fish

function fish_greeting
    fortune | cowsay | lolcat -p 10 -t
end
