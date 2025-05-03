#!/bin/bash

MODE="$1"

CONFIG_DIR=${HOME}/.config
DIRS=(foot hypr readline nvim waybar fuzzel)
FILES=(.bashrc .bash_profile)

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
        echo [Setting up dotfiles with symlinks]
        for dir in ${DIRS[@]}; do
            echo "    Linking $dir"
            rm -rf $CONFIG_DIR/$dir
            ln -s $(pwd)/$dir $CONFIG_DIR
        done
        for file in ${FILES[@]}; do
            echo "    Linking $file"
            rm -f $HOME/$file
            ln -s $(pwd)/$file $HOME
        done
        ;;
    *)
        echo "Use "backup" or "setup" mode"
esac
