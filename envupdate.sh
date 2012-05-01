#!/usr/bin/env bash

# Small script to update my env. Too lazy to write this into my python setup script

# A die function as always

die() {
printf '%s\n' "$@" >&2
exit 1
}

cd ~/dev/dotfiles
git pull
exec zsh

