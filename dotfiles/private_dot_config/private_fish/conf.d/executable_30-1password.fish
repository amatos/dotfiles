#!/usr/bin/env fish

# Source 1Password CLI

if [ -e "$HOME/.config/op/plugins.sh" ]
  source $HOME/.config/op/plugins.sh
  set -gx SSH_AUTH_SOCK $HOME/.1password/agent.sock
end
