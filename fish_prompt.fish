# name: jacanotsomuch
# tweaked version of the jacaetevha theme

function parse_git_dirty
    if test (git status 2> /dev/null ^&1 | tail -n1) != "nothing to commit, working directory clean"
        echo (set_color red)
    else
        echo (set_color brown)
    end
end

function parse_git_branch
    set -l branch (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    parse_git_dirty
    printf '(%s)' $branch
    set_color normal
end

function fish_prompt
    # Line 1
    set_color yellow
    printf '%s' (whoami)
    set_color normal
    printf ' at '

    set_color magenta
    printf '%s' (hostname|cut -d . -f 1)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s ' (prompt_pwd)
    set_color normal

    if test -z (git branch -quiet 2>| awk '/fatal:/ {print "no git"}')
        printf '%s' (parse_git_branch)
    end

    # Line 2
    echo
    printf '↪  '
    set_color normal
end

