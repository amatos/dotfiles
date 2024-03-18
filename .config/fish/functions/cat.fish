function cat
    if [ -e /usr/bin/bat ]
        bat $argv
    else
        command cat $argv
    end
end
