#!/bin/bash

mkdir -p ~/.local/bin

if [ "Linux" = `uname` ]; then
    ln -sf ~/dotfiles/linux-bin/* ~/.local/bin/
fi

