#!/usr/bin/env fish

if test "$OS" = Darwin
    function open --wraps open
        command open "$argv"
    end
else
    function open --wraps xdg-open
        xdg-open "$argv" >/dev/null
    end
end
