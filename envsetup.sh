#!/bin/bash

# Environment setup redone in bash, because using call in Python is lame
# Basic requirements - bash, sudo (Also make sure your user has sudo privileges!)

# TODO - OSX MacPorts support

# a die function as always
die() {
    printf '%s\n' "$@" >&2
    exit 1
}

# Some variable(s)

userdistro="NULL"
repo="https://github.com/staticsafe/dotfiles.git"

# Lets get this party on the road, shall we?

sudocheck() {
    hash sudo &>/dev/null || die 'sudo does not exist, exiting'
    printf '%s\n' "sudo check : PASSED"
}

distrocheck() {
    hash apt-get &>/dev/null && userdistro="Debian" # For Debian based distros.
    hash yum &>/dev/null && userdistro="Fedora" # For RHEL/CentOS/Fedora
    hash pacman &>/dev/null && userdistro="Arch" # For Arch Linux
}

installpackages() {
    if [[ "$userdistro" == "Debian" ]]; then
        sudo apt-get install --assume-yes vim zsh tmux git subversion
    elif [[ "$userdistro" == "Fedora" ]]; then
        sudo yum install -y vim zsh tmux git subversion
    elif [[ "$userdistro" == "Arch" ]]; then
        sudo pacman --no-confirm -S vim zsh tmux git subversion
    else
        die 'Your distro does not have a package manager supported by this script, exiting!'
    fi
}

changeshell() {
    if [[ $SHELL == "/usr/bin/zsh" || $SHELL == "/bin/zsh" ]]; then
        printf '%s\n' "Your default shell is already zsh, continuing."
    else
        chsh -s $(which zsh)
    fi
}

linkfiles() {
     find ~/dev/dotfiles -type f -name ".*" -exec ln -s -f {}
            --target-directory=$HOME \;
     ln -s ~/dev/dotfiles/.zsh $HOME
     ln -s ~/dev/dotfiles/.vim $HOME
     touch ~/.zhistory
}


getdotfiles() {
    if [[ -d ~/dev/dotfiles ]]; then
        cd ~/dev/dotfiles
        git pull
        linkfiles
    else
        mkdir ~/dev
        cd ~/dev
        git clone $repo
        linkfiles
    fi
}

sudocheck
distrocheck
installpackages
changeshell
getdotfiles


