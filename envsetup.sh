#!/usr/bin/env bash

# Environment setup redone in bash, because using call in Python is lame
# Basic requirements - bash, sudo (Also make sure your user has sudo privileges!)

# a die function as always
die() {
    printf '%s\n' "$@" >&2
    exit 1
}

# Some variable(s)

userdistro="NULL"
repo="git://github.com/staticsafe/dotfiles.git"

portpath="/opt/local/bin/port" # This is the default install directory for the MacPorts port binary, you may find this useful.

# Lets get this party on the road, shall we?

sudocheck() {
    hash sudo &>/dev/null || die 'sudo does not exist, exiting'
    printf '%s\n' "sudo check : PASSED"
}

distrocheck() {
    hash apt-get &>/dev/null && userdistro="Debian" # For Debian based distros.
    hash yum &>/dev/null && userdistro="Fedora" # For RHEL/CentOS/Fedora
    hash pacman &>/dev/null && userdistro="Arch" # For Arch Linux
    hash pkg_add &>/dev/null && userdistro="FreeBSD" # For FreeBSD
}

installpackages() {
    if [[ "$userdistro" == "Debian" ]]; then
        sudo apt-get install --assume-yes vim zsh tmux git subversion mercurial most python-pip
    elif [[ "$userdistro" == "Fedora" ]]; then
        sudo yum install -y vim zsh tmux git subversion mercurial most python-pip
    elif [[ "$userdistro" == "Arch" ]]; then
        sudo pacman --noconfirm -S vim zsh tmux git mercurial subversion most python-pip
    elif [[ "$userdistro" == "FreeBSD" && $(uname -s) == "FreeBSD" ]]; then
        sudo pkg_add -r vim zsh tmux git subversion mercurial most py27-pip
    else
        printf '%s\n' "Your distro's package manager is not supported in this script, continuing with changing shell & linking dotfiles."
    fi
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
     ln -sf ~/dev/dotfiles/.zshrc $HOME/
     ln -sf ~/dev/dotfiles/.vimrc $HOME/
     ln -sf ~/dev/dotfiles/.tmux.conf $HOME/
     ln -sf ~/dev/dotfiles/.conkyrc $HOME/
     ln -sf ~/dev/dotfiles/.zsh $HOME/
     ln -sf ~/dev/dotfiles/.vim $HOME/
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
exec zsh
