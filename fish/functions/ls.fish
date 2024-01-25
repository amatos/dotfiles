function ls
    if [ -e /usr/bin/lsd ]
        lsd $argv
    else
        ls $argv
    end
end
