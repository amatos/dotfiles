# Avoid issues with GPG
set -xg GPG_TTY $(tty)

# My GnuPG key
set -xg KEYID 5FC8FE1141FA769594E91E48F41BDBF6171A3BB4
set -xg SHORTKEYID 0xF41BDBF6171A3BB4

# Man pager
set -xg MANPAGER 'less -X'

set -xg EDITOR 'vi'
set -xg VISUAL 'kate'
