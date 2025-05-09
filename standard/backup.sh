#!/bin/bash

MODE="$1"

CONFIG_DIR=${HOME}/.config
DIRS=(foot MangoHud hypr readline nvim waybar)
FILES=(.bashrc .bash_profile .local/bin/fzf_cd.sh)

case "$MODE" in
    backup)
        echo [Backing up dotfiles into $(pwd)]
        for dir in ${DIRS[@]}; do
            echo "    Copying $CONFIG_DIR/$dir"
            cp -r $CONFIG_DIR/$dir .
        done
        for file in ${FILES[@]}; do
            echo "    Copying $HOME/$file"
            cp $HOME/$file .
        done
        ;;
    setup)
        echo [Setup dotfiles]
        for dir in ${DIRS[@]}; do
            echo "    Copying $dir into $CONFIG_DIR"
            cp -r $(pwd)/$dir $CONFIG_DIR
        done
        for file in ${FILES[@]}; do
            echo "    Copying $file into $HOME"
            cp $file $HOME
        done
        ;;
    *)
        echo "Use "backup" or "setup" mode"
esac
