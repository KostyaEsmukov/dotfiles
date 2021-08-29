#!/bin/bash

set -euxo pipefail

if which brew; then
    brew tap neovim/neovim
    packages="
        clang-format
        ctags-exuberant
        gcc
        gopls
        neovim
        npm
        ruby@2.7
        the_silver_searcher
        wget
    "
    brew install $packages || brew upgrade $packages

else
    echo "Unsupported OS"
    exit 1
fi

# zsh correctly initializes pyenv
zsh -ls < /dev/null << 'EOF' || true
source ~/.zshrc

pyenv shell system
pip3 install --user --upgrade \
    'isort>=5' \
    black \
    coverage \
    flake8 \
    flake8-isort \
    mypy \
    pipenv \
    py-spy \
    pylint \
    pyls-black \
    pyls-isort \
    pyls-mypy \
    python-language-server'[all]' \
    pyupgrade \
    tox \
    tox-pyenv \
    tox-venv \
;

pyenv shell `pyenv versions | egrep -o '2\.7[.0-9]+' | tail -1`
pyenv virtualenv-delete -f neovim_py2
pyenv virtualenv neovim_py2
pyenv shell neovim_py2
pip install --upgrade neovim

pyenv shell `pyenv versions | egrep -o '3\.8[.0-9]+' | tail -1`
pyenv virtualenv-delete -f neovim_py3
pyenv virtualenv neovim_py3
pyenv shell neovim_py3
pip install --upgrade neovim

EOF


if which brew; then
    npm install -g neovim
    sudo gem install neovim
    npm install -g javascript-typescript-langserver
    npm install -g prettier
fi


rm -Rf ~/.config/nvim/
mkdir -p ~/.config/nvim/
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/colors/kalisi.vim --create-dirs https://raw.githubusercontent.com/freeo/vim-kalisi/master/colors/kalisi.vim

if which brew; then
    mkdir -p ~/Library/Fonts/
    pushd $_
fi

if [ ! -r "Cousine Regular Nerd Font Complete.ttf" ]; then
    wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Cousine/Regular/complete/Cousine%20Regular%20Nerd%20Font%20Complete.ttf
    if which brew; then
        echo "Change the font manually in the iTerm2 settings to 'Cousine'."
    fi
fi
popd


ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/
nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall
