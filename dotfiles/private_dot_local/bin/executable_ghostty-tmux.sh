#!/bin/bash

export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
[ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

SESSION_NAME="ghostty_$(uuidgen)" # Generates a unique name for each new window

# tmux new-session -s $SESSION_NAME

# SESSION_NAME="ghostty"

# Check if the session already exists
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
  # If the session exists, reattach to it
  tmux attach-session -t $SESSION_NAME
else
  # If the session doesn't exist, start a new one
  tmux new-session -s $SESSION_NAME -d
  tmux attach-session -t $SESSION_NAME
fi
