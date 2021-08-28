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
        cloc \
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
        \
        coreutils \
        gawk \
        gnu-getopt \
        gnu-sed \
        gnu-tar \
    ;


elif which apt; then

# elif which lsb_release && [ "Debian" = `lsb_release -si` ]; then
    sudo apt install \
        ack-grep \
        cloc \
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
