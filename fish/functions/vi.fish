function vi
    if [ -e /usr/bin/vim ]
        vim $argv
    else if [ -e /usr/bin/nvim ]
        nvim $argv
    end
end

