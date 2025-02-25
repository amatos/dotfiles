#!/usr/bin/env fish

abbr -a g --position command git
abbr -a d --position command dotfiles

################################################################################
#                                  Functions                                   #
################################################################################

function git_develop_branch
    command git rev-parse --git-dir &>/dev/null || return
    set -l branch

    for branch in dev devel develop development
        if command git show-ref -q --verify refs/heads/$branch
            echo $branch
            return 0
        end
    end

    echo develop
    return 1
end

function git_main_branch
    command git rev-parse --git-dir &>/dev/null || return
    set -l ref

    for ref in
        refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,master}
        if command git show-ref -q --verify $ref
            echo (basename $ref)
            return 0
        end
    end

    echo main
    return 1
end

function git_current_branch
    set -l ref (git symbolic-ref --quiet HEAD 2>/dev/null)
    set -l ret $status

    if [ $ret -ne 0 ]
        [ $ret -eq 128 ] && return # no git repo
        set ref (git rev-parse --short HEAD 2>/dev/null) || return
    end

    echo (string replace "refs/heads/" "" $ref)
end
