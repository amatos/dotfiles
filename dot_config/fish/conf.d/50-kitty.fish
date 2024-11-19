#!/usr/bin/env fish

if [ -e /usr/bin/kitty ]
    function icat
        kitten icat $argv
    end
    function ssh
        kitten ssh $argv
    end

end
