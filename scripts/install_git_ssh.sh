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

# zsh correctly initializes pyenv
cat | zsh -ls << 'EOF' || true
source ~/.zshrc
deactivate

pyenv shell system
pip3 install --user --upgrade \
    https://github.com/jeffkaufman/icdiff/archive/master.tar.gz
EOF

echo "Don't forget to get your SSH and GPG keys!"
