#!/bin/bash

set -euxo pipefail

if which brew; then
    brew tap neovim/neovim
    packages="
        clang-format
        ctags-exuberant
        fzf
        gcc
        go
        gopls
        llvm
        neovim
        npm
        pgformatter
        prettier
        ruby
        shellcheck
        staticcheck
        the_silver_searcher
        typescript-language-server
        wget
    "
    brew install $packages || brew upgrade $packages

else
    sudo -E apt install \
        neovim \
        python3 \
        python3-pip \
        shellcheck \
        silversearcher-ag \
        wget \
    ;
fi

# zsh correctly initializes pyenv
zsh -ls < /dev/null << 'EOF' || true
source ~/.zshrc

pyenv shell system
python3 -m pip install --break-system-packages --user --upgrade \
    black \
    coverage \
    flake8 \
    flake8-isort \
    isort \
    mypy \
    pip-tools \
    pipenv \
    py-spy \
    pylint \
    pyls-isort \
    pylsp-mypy \
    python-lsp-black \
    python-lsp-ruff \
    python-lsp-server'[all]' \
    pyupgrade \
    ruff \
    tox \
    twine \
    virtualenv-pyenv \
;

python3 -m pip uninstall tox-venv tox-pyenv

pyenv shell `pyenv versions | egrep -o '3\.8[.0-9]+' | tail -1`
pyenv virtualenv-delete -f neovim_py3
pyenv virtualenv neovim_py3
pyenv shell neovim_py3
pip install --upgrade neovim

EOF


rm -Rf ~/.config/nvim/
mkdir -p ~/.config/nvim/
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/colors/kalisi.vim --create-dirs https://raw.githubusercontent.com/freeo/vim-kalisi/master/colors/kalisi.vim

ln -fsv ~/dotfiles/nvim/init.vim ~/.config/nvim/
mkdir -p ~/.config/nvim/spell/
ln -fsv ~/dotfiles/nvim/spell/en.utf-8.add ~/.config/nvim/spell/en.utf-8.add
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
