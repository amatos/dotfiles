#!/usr/bin/env fish

# My GnuPG key
set -xg KEYID 5FC8FE1141FA769594E91E48F41BDBF6171A3BB4
set -xg SHORTKEYID 0xF41BDBF6171A3BB4

if test "$(command -v gpgconf &>/dev/null)"
    set -gx GPG_TTY (tty)
    gpgconf --launch gpg-agent
end
