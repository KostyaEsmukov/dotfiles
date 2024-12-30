#!/bin/bash

set -euxo pipefail

if which brew; then
    brew install \
        gnupg pinentry-mac git

    if ! grep -q pinentry-program ~/.gnupg/gpg-agent.conf; then
        mkdir -p ~/.gnupg/
        chmod 700 ~/.gnupg/
        echo "pinentry-program /opt/homebrew/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
    fi

elif which apt; then

    sudo -E apt install \
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
if which brew; then
    if [ ! -f ~/.ssh/config ]; then
        cp ~/dotfiles/ssh/config.initial.macos ~/.ssh/config
    fi
    chmod 750 ~/.ssh/config
fi

echo "Don't forget to bring your SSH and GPG keys!"
