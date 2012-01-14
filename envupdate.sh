#!/bin/bash

# Small script to update my env. Too lazy to write this into my python setup script

# A die function as always

die() {
printf '%s\n' "$@" >&2
exit 1
}

cd

# Update all the conf files here
printf '%s\n' "Updating dotfiles now!"
wget --no-check-certificate -O .zshrc https://raw.github.com/staticsafe/dotfiles/master/.zshrc
wget --no-check-certificate -O .vimrc https://raw.github.com/staticsafe/dotfiles/master/.vimrc
wget --no-check-certificate -O .tmux.conf https://raw.github.com/staticsafe/dotfiles/master/.tmux.conf

# vim dir
rm -r ~/.vim
wget -O vimdir.tar.bz2 http://dl.dropbox.com/u/2888062/vimdir.tar.bz2
tar xjvf vimdir.tar.bz2