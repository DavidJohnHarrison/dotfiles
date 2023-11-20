#!/bin/sh
# Load config
[ -s '$HOME/.dotfiles/.config' ] && \.'$HOME/.dotfiles/.config'
[ -s '$HOME/.dotfiles/.config_local' ] && \. '.$HOME/.dotfiles/config_local'

# Configure dotfiles git repo
(
    cd $DOTFILES_GIT
    git config --local status.showUntrackedFiles no
    git --git-dir $DOTFILES_GIT --work-tree=$HOME submodule update --init --recursive
)

