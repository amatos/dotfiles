#!/usr/bin/env fish

if [ -e /usr/bin/kitty ]
    function icat
        kitten icat $argv
    end
end
