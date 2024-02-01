function rm
    if [ -e /usr/bin/trash ]
        trash $argv
    else
        command rm $argv
    end
end
