#!/usr/bin/env bash

# Basic requirements - bash, git

# a die function as always
die() {
    printf '%s\n' "$@" >&2
    exit 1
}

# Some variable(s)

repo="git://github.com/staticsafe/dotfiles.git"

# Lets get this party on the road, shall we?

gitcheck() {
    hash git &>/dev/null || die 'git does not exist, exiting'
    printf '%s\n' "git check : PASSED"
}

changeshell() {
    if [[ $SHELL == $(command -v zsh) ]]; then
        printf '%s\n' "Your default shell is already zsh, continuing."
    else
        chsh -s $(command -v zsh)
        printf '%s\n' "Default shell changed to zsh, logout and login to see changes"
    fi
}

linkfiles() {
     #find ~/dev/dotfiles -type f -name ".*" -execdir ln -s -f {}
     #       --target-directory=$HOME \; # removed until I can figure out the issue
     ln -sf ~/dotfiles/.zshrc $HOME/
     ln -sf ~/dotfiles/.vimrc $HOME/
     ln -sf ~/dotfiles/.tmux.conf $HOME/
     ln -sf ~/dotfiles/.conkyrc $HOME/
     ln -sf ~/dotfiles/.zsh $HOME/
     ln -sf ~/dotfiles/.vim $HOME/
     touch ~/.zhistory
}

getdotfiles() {
    if [[ -d ~/dotfiles ]]; then
        cd ~/dotfiles
        git pull
        linkfiles
    else
        cd
        git clone $repo
        linkfiles
    fi
}

gitcheck
changeshell
getdotfiles
exec zsh
