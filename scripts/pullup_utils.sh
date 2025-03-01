#!/bin/bash

# This script must be idempotent

set -euxo pipefail

if [ "Darwin" = `uname` ] && ! which brew; then
    # https://brew.sh/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if which brew; then

    brew install \
        cloc \
        curl \
        ffmpeg \
        git \
        grep \
        htop \
        httpie \
        jq \
        mtr \
        ncdu \
        nmap \
        pv \
        pwgen \
        rename \
        rsync \
        telnet \
        the_silver_searcher \
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
    sudo -E apt install \
        bind9-dnsutils \
        bind9-host \
        bmon \
        cloc \
        curl \
        git \
        htop \
        httpie \
        jq \
        ncdu \
        nmap \
        pwgen \
        rename \
        rsync \
        silversearcher-ag \
        telnet \
        tmux \
        tree \
        unzip \
    ;

else
    echo "Unsupported OS"
    exit 1
fi
