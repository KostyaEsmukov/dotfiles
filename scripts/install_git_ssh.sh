#!/bin/bash

set -euxo pipefail

if which brew; then
    brew install git

    echo "Install GPG Suite manually"
    open "https://gpgtools.org/"

elif which dnf; then
    sudo dnf install git gpg

else
    echo "Unsupported OS"
    exit 1
fi


cat >> ~/.gitconfig <<EOF

[include]
    path = dotfiles/gitconfig
EOF

echo "Don't forget to get your SSH and GPG keys!"
