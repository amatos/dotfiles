function zed -d "Zed, the editor"
    if [ -e /usr/bin/zeditor ]
        zeditor $argv
    end
end
