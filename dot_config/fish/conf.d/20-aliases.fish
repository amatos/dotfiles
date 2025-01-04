#!/usr/bin/env fish

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Shell aliases.
abbr -a rl --position command "source $XDG_CONFIG_HOME/fish/config.fish"
abbr -a c --position command clear
abbr -a e --position command "$EDITOR"
abbr -a v --position command "$VISUAL"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# CD up on steriods.
function _cd_up_func --argument-names dots
    set -f dots (string sub --start 3 "$dots")
    set -f cmd "cd .."

    while string length -q "$dots"
        set cmd "$cmd/.."
        set dots (string sub --start 2 "$dots")
    end

    echo "$cmd"
end

abbr -a _cd_up --position command --regex "\.{2,}" --function _cd_up_func

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Execute .txt files as a command.
function _edit_txt_func --argument-names file
    echo "$EDITOR $file"
end

abbr -a _edit_txt --position command --regex ".+\.txt" --function _edit_txt_func

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

abbr -a L --position anywhere --set-cursor "% | less"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Default command options.

abbr -a cp --position command "cp -iv"
#                                  │└─ list copied files
#                                  └─ prompt before overwriting an existing file

abbr -a mkdir --position command "mkdir -pv"
#                                        │└─ list created directories
#                                        └─ create intermediate directories

abbr -a mv --position command "mv -iv"
#                                  │└─ list moved files
#                                  └─ prompt before overwriting an existing file

abbr -a rm --position command "trash"
#abbr -a rm --position command "trash -rf"
#                                  │└─ do not ask for confirmation
#                                  └─ recursively remove directories and files

# Colored grep output.
abbr -a grep --position command "grep --color=auto"
abbr -a fgrep --position command "fgrep --color=auto"
abbr -a egrep --position command "egrep --color=auto"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Combinations.

function mkcd -d "Make a directory and CD into it"
    mkdir "$argv" && cd "$argv"
end

function cdls -d "CD into a directory and list its contents"
    cd "$argv" && ls
end

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Check battery.

function batt -d "Check battery percentage"
    upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
        | grep -E "state|time to|percentage"
end
