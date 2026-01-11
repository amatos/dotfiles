# Install fisher if not already installed
install_fisher

set -q fisher_path; or set -Ux fisher_path "$HOME/.config/fish"

# Standalone env vars
set -gx EDITOR nvim
set -gx CARGO_INSTALL_ROOT ~/.cargo

# Colorize manpages using bat
set -q MANPAGER; or set -Ux MANPAGER 'sh -c "col -bx | bat --language=man --style=grid --color=always --decorations=always"'
set -q MANROFFOPT; or set -Ux MANROFFOPT -c

if [ -e /opt/homebrew/bin/brew ]
    /opt/homebrew/bin/brew shellenv | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init --disable-up-arrow fish | source # Initialize atuin
    fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc # Display fastfetch
    starship init fish | source # Initialize starship
    jenv init - | source # Initialize jenv
    set -gx BAT_STYLE auto
    set -gx VISUAL=/opt/homebrew/bin/zed -w
else
    set -gx BAT_STYLE plain
end

fish_config theme choose "Dracula Official"
