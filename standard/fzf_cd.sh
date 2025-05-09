#!/bin/bash

# fd - cd to selected directory
fd() {
    local FZF_CMD="$1"
    local dir
    dir=$(find ${HOME} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"

    if [[ -n $FZF_CMD ]]; then
        "$FZF_CMD"
    fi
}

fe() {
    local FZF_CMD="$1"
    local file
    file=$(find $HOME -maxdepth 3 -type f -path '*/.*' \
        | fzf --min-height 20 --scheme=path)

    if [[ -n $FZF_CMD ]]; then
        "$FZF_CMD" $file
    fi
}
