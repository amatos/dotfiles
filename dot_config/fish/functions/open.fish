#!/usr/bin/env fish

if test "$OS" = Darwin
    function open --wraps open
        open "$argv"
    end
else
    function open --wraps xdg-open
        xdg-open "$argv" >/dev/null
    end
end
