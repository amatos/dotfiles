#!/usr/bin/env fish

# Set visual editors based on the following preference hierarchy:
# 1. zed
# 2. subl
# 3. bbedit

if [ -e /opt/homebrew/bin/zed ]
    set -gx VISUAL "/opt/homebrew/bin/zed -w "
else if [ -e /usr/bin/zed ]
    set -gx VISUAL "/usr/bin/zed -w "
else if [ -e /opt/homebrew/bin/subl ]
    set -gx VISUAL "/opt/homebrew/bin/subl -w "
else if [ -e /usr/bin/subl ]
    set -gx VISUAL "/usr/bin/subl -w "
else if [ -e /opt/homebrew/bin/bbedit ]
    set -gx VISUAL "/opt/homebrew/bin/bbedit --wait "
else if [ -e /usr/bin/bbedit ]
    set -gx VISUAL "/usr/bin/bbedit --wait "
end
