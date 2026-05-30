# ===========================================================================
# Directory Listing (macOS/BSD ls)
# ===========================================================================
# -a: show hidden files
# -h: human-readable sizes
# -l: long format
# -F: append type indicator (/ for dirs, * for executables)
# -G: colorized output (macOS BSD ls)
# -D: date format (macOS BSD ls)
[ -f "$HOMEBREW_PREFIX/bin/eza" ] && alias ls="eza --icons"
alias ll="ls -ahlFG -D '%Y-%m-%d %H:%M:%S'"
alias llt="ls -ahltFG -D '%Y-%m-%d %H:%M:%S'" # sorted by time
alias lls="ls -ahlsFG -D '%Y-%m-%d %H:%M:%S'" # show size
alias "ll@"="ls -@ahlFG -D '%Y-%m-%d %H:%M:%S'" # show extended attributes (macOS)

# ===========================================================================
# Archive (macOS-friendly tar)
# ===========================================================================
# COPYFILE_DISABLE=1: don't include macOS resource forks (portable across BSD/GNU tar)
# --exclude='.DS_Store': skip Finder metadata files
alias tgz="COPYFILE_DISABLE=1 tar --exclude='.DS_Store' -czf"

# ===========================================================================
# tmux (session management)
# ===========================================================================
if [ -f "$HOMEBREW_PREFIX/bin/tmux" ]; then
    alias ta="tmux attach -t" # Attach to named session
    alias tl="tmux list-sessions" # List active sessions
    alias tn="tmux new -s" # Create named session
fi

[ -f "$HOMEBREW_PREFIX/bin/bat" ] && alias cat="bat "
