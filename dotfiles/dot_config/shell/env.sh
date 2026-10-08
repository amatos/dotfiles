# Ansible managed
# Session environment shared by bash and zsh (home.sessionPath / sessionVariables).

case ":$PATH:" in *":/Library/TeX/texbin:"*) ;; *) PATH="/Library/TeX/texbin:$PATH" ;; esac
case ":$PATH:" in *":/Users/alberth/.cargo/bin:"*) ;; *) PATH="/Users/alberth/.cargo/bin:$PATH" ;; esac
case ":$PATH:" in *":/opt/homebrew/opt/rustup/bin:"*) ;; *) PATH="/opt/homebrew/opt/rustup/bin:$PATH" ;; esac
case ":$PATH:" in *":/opt/homebrew/opt/openjdk@21/bin:"*) ;; *) PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH" ;; esac
case ":$PATH:" in *":/opt/homebrew/sbin:"*) ;; *) PATH="/opt/homebrew/sbin:$PATH" ;; esac
case ":$PATH:" in *":/opt/homebrew/bin:"*) ;; *) PATH="/opt/homebrew/bin:$PATH" ;; esac
case ":$PATH:" in *":/Users/alberth/.local/bin:"*) ;; *) PATH="/Users/alberth/.local/bin:$PATH" ;; esac
export PATH

export EDITOR=nvim
