#!/bin/bash

# This script must be idempotent

set -euxo pipefail

if [ "Darwin" = `uname` ] && ! which brew; then
    # https://brew.sh/
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if which brew; then

    brew install \
        htop ack pwgen \
        git ncdu httpie \
        tmux tig \
        jq \
        rsync nmap telnet tree unzip \
        gawk gnu-sed gnu-tar md5sha1sum

elif which dnf; then

    sudo dnf install \
        htop ack pwgen \
        git ncdu httpie \
        tmux tig \
        jq \
        rsync nmap telnet tree unzip

elif which apt; then

# elif which lsb_release && [ "Debian" = `lsb_release -si` ]; then
    sudo apt install \
        htop ack-grep pwgen \
        git ncdu httpie \
        tmux tig \
        jq \
        rsync nmap telnet tree unzip

else
    echo "Unsupported OS"
    exit 1
fi