#!/bin/bash

# This script must be idempotent

set -euxo pipefail

if [ "Darwin" = `uname` ] && ! which brew; then
    # https://brew.sh/
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if which brew; then

    brew install \
        ack \
        coreutils \
        curl \
        gawk \
        git \
        gnu-getopt \
        gnu-sed \
        gnu-tar \
        htop \
        httpie \
        jq \
        ncdu \
        nmap \
        pwgen \
        rsync \
        telnet \
        tmux \
        tree \
        unzip \
    ;


elif which apt; then

# elif which lsb_release && [ "Debian" = `lsb_release -si` ]; then
    sudo apt install \
        ack-grep \
        curl \
        git \
        htop \
        httpie \
        jq \
        ncdu \
        nmap \
        pwgen \
        rsync \
        telnet \
        tmux \
        tree \
        unzip \
    ;

else
    echo "Unsupported OS"
    exit 1
fi
