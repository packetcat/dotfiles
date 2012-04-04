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
repo="https://github.com/staticsafe/dotfiles.git"

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
    hash port &>/dev/null && userdistro="OSX" # For OSX, make sure the port binary is in your PATH first.
}

installpackages() {
    if [[ "$userdistro" == "Debian" ]]; then
        sudo apt-get install --assume-yes vim zsh tmux git subversion most
    elif [[ "$userdistro" == "Fedora" ]]; then
        sudo yum install -y vim zsh tmux git subversion most
    elif [[ "$userdistro" == "Arch" ]]; then
        sudo pacman --no-confirm -S vim zsh tmux git subversion most
    elif [[ "$userdistro" == "OSX" ]]; then
        sudo port install vim zsh tmux git subversion most
        #echo "export PATH=/opt/local/bin:/opt/local/sbin:$PATH" >> ~/.zshenv # This adds the port binary path, so that zsh can use it after, commented out by default.
    else
        die 'Your distro does not have a package manager supported by this script, exiting!'
    fi
}

changeshell() {
    if [[ $SHELL == "/usr/bin/zsh" || $SHELL == "/bin/zsh" ]]; then
        printf '%s\n' "Your default shell is already zsh, continuing."
    else
        chsh -s $(which zsh)
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


