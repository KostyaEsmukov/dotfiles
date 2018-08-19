#!/bin/bash

# This script must be idempotent

set -euxo pipefail

if which brew; then
    brew install vim
    brew link vim
elif which dnf; then
    sudo dnf install vim
elif which apt; then
    sudo apt install vim
else
    echo "Unsupported OS"
    exit 1
fi

rm -Rf ~/.vim/
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ln -svf ~/dotfiles/vim/.vimrc ~/.vimrc
vim +PluginInstall +qall
