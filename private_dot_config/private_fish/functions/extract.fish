#!/usr/bin/env fish

# Extracts archived files / mounts disk images.
# Usage: extract <file>

function extract -a file
    if test -f "$file"
        switch $file
            case "*.tar.bz2"
                tar -jxvf $file
            case "*.tar.gz"
                tar -zxvf $file
            case "*.bz2"
                bunzip2 $file
            case "*.dmg"
                if test "$(uname)" = Darwin
                    hdiutil mount $file
                end
            case "*.gz"
                gunzip $file
            case "*.tar"
                tar -xvf $file
            case "*.tbz2"
                tar -jxvf $file
            case "*.tgz"
                tar -zxvf $file
            case "*.zip"
                unzip $file
            case "*.ZIP"
                unzip $file
            case "*pax"
                cat $file | pax -r
            case "*.pax.Z"
                uncompress $file --stdout | pax -r
            case "*.rar"
                unrar x $file
            case "*.Z"
                uncompress $file
            case "*"
                echo "'$file' cannot be extracted/mounted via extract()."
        end
    else
        echo "'$file' is not a valid file."
    end
end
