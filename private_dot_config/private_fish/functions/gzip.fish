function gzip
    if [ -e /usr/bin/pigz ]
        pigz $argv
    else
        command gzip $argv
    end
end
