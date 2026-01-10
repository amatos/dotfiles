if [ -e /opt/homebrew/bin/brew ]
    /opt/homebrew/bin/brew shellenv | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init --disable-up-arrow fish | source # Initialize atuin
    fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc # Display fastfetch
    starship init fish | source # Initialize starship
    jenv init - | source # Initialize jenv
end

fish_config theme choose "Dracula Official"
