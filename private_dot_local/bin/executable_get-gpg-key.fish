#!/usr/bin/env fish

set -f key (\
        gpg --list-secret-keys \
        | grep --color=auto "Key fingerprint" \
        | cut -d "=" -f 2 \
        |sed 's/ //g'
    )

echo "$key"
