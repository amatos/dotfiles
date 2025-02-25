function vim
    if [ -e /usr/bin/nvim ]
        nvim $argv
    else if [ -e /usr/bin/vim ]
        command vim $argv
    else
        vi $argv
    end
end
