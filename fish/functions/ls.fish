function ls
    if [ -e /usr/bin/lsd ]
        lsd $argv
    else
        command ls $argv
    end
end
