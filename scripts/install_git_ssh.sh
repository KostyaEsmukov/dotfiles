#!/bin/bash

set -euxo pipefail

if which brew; then
    brew install git

    echo "Install GPG Suite manually"
    open "https://gpgtools.org/"

elif which apt; then

    sudo apt install \
        gnupg git

else
    echo "Unsupported OS"
    exit 1
fi


cat >> ~/.gitconfig <<EOF

[include]
    path = dotfiles/gitconfig
EOF

mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ ! -f ~/.ssh/config ]; then
    cp ~/dotfiles/ssh/config.initial ~/.ssh/config
fi
chmod 750 ~/.ssh/config

echo "Don't forget to bring your SSH and GPG keys!"
