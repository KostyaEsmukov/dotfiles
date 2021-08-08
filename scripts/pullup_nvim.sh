#!/bin/bash

set -euxo pipefail

if which brew; then
    brew tap neovim/neovim
    packages="neovim
        ruby
        npm
        wget
        the_silver_searcher
        clang-format
        ctags-exuberant
        gcc"
    brew install $packages || brew upgrade $packages

else
    echo "Unsupported OS"
    exit 1
fi

# zsh correctly initializes pyenv
cat | zsh -ls << 'EOF' || true
source ~/.zshrc
deactivate

pyenv shell system
pip3 install --user --upgrade \
    black mypy pipenv \
    flake8 pylint \
    'isort>=5' flake8-isort \
    python-language-server'[all]' \
    pyls-black pyls-isort pyls-mypy \
    pyupgrade \
    coverage \
    tox tox-venv tox-pyenv

pyenv shell `pyenv versions | egrep '^\s*2\.7' | tail -1`
rmvirtualenv neovim_py2
mkvirtualenv neovim_py2
pip install --upgrade neovim
deactivate

pyenv shell `pyenv versions | egrep '^\s*3\.7' | tail -1`
rmvirtualenv neovim_py3
mkvirtualenv neovim_py3
pip install --upgrade neovim
deactivate

echo press enter
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
nvim +PlugInstall +UpdateRemotePlugins +qall

