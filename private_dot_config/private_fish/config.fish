if [ -e /opt/homebrew/bin/brew ]
    /opt/homebrew/bin/brew shellenv | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init --disable-up-arrow fish | source
    fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
end

fish_config theme choose "Dracula Official"
