#!/bin/bash

# https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles

set -euxo pipefail

cd "$(dirname "$0")"
ln -s "$(pwd)" ~/dotfiles
export APT_CONFIG=.apt.conf

scripts/pullup_utils.sh
scripts/install_zsh.sh
scripts/pullup_vim.sh
scripts/install_git_ssh.sh
