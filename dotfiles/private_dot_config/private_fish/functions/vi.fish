function vi
    if [ -e /opt/homebrew/bin/hx ]
        hx $argv
    else if [ -e /usr/bin/nvim ]
        nvim $argv
    else if [ -e /opt/homebrew/bin/nvim ]
        nvim $argv
    else if [ -e /usr/bin/vim ]
        vim $argv
    else
        command vi $argv
    end
end
