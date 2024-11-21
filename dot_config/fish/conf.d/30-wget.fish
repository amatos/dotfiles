#!/usr/bin/env fish

set -gx WGETRC "$XDG_CONFIG_HOME/wgetrc"

#function wget --wraps wget
#    wget --hsts-file="$XDG_CACHE_HOME/wget-hsts" $argv
#end
