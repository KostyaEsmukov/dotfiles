#!/bin/bash

# This script must be idempotent

# Note:
# - .vimrc is linked by pullup_vim.sh
# - nvim/init.vim is linked by pullup_nvim.sh
# - gitconfig is linked by install_git_ssh.sh

mkdir -p ~/.config

ln -svf ~/dotfiles/flake8 ~/.config/flake8
ln -svf ~/dotfiles/gitignore_global ~/.gitignore_global
ln -svf ~/dotfiles/isort.cfg ~/.isort.cfg
ln -svf ~/dotfiles/pg_format ~/.pg_format
ln -svf ~/dotfiles/tmux.conf ~/.tmux.conf

mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty/
ln -svf ~/dotfiles/ghostty ~/Library/Application\ Support/com.mitchellh.ghostty/config

# Cleanup previously existing links
[ -L ~/.ackrc ] && rm -vf ~/.ackrc
[ -L ~/.ideavimrc ] && rm -vf ~/.ideavimrc
[ -L ~/.tigrc ] && rm -vf ~/.tigrc

true
