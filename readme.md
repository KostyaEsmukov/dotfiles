# dotfiles (MacOS + Fedora)

    git clone https://github.com/KostyaEsmukov/dotfiles.git ~/dotfiles

## Zsh + oh-my-zh

    # vi ~/.zshrc

    source ~/dotfiles/zshrc/ohmyzsh
    # source $ZSH/oh-my-zsh.sh
    source ~/dotfiles/zshrc/zshrc

## Neovim (local user)

    # macos
    # brew tap neovim/neovim
    brew install neovim
    pip3 install --user --upgrade flake8 isort flake8-isort black mypy

    pyenv shell 2.7
    mkvirtualenv neovim_py2
    pip install --upgrade neovim
    pyenv shell 3.6
    mkvirtualenv neovim_py3
    pip install --upgrade neovim
    deactivate

    brew install ag
    brew install ctags-exuberant

    # fedora
    sudo dnf install neovim ruby ruby-devel @development-tools redhat-rpm-config the_silver_searcher ctags

    npm install -g neovim
    gem install neovim
    mkdir -p ~/.config/nvim/
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.config/nvim/colors/kalisi.vim --create-dirs https://raw.githubusercontent.com/freeo/vim-kalisi/master/colors/kalisi.vim

    # Install fonts and set them in your terminal
    # https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Cousine

    ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/
    nvim
    # :PlugInstall
    # :UpdateRemotePlugins
    # ~/.fzf/install

## Vim

    # macos:
    brew install vim
    brew link vim

    # fedora:
    sudo dnf install vim

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    ln -sv ~/dotfiles/vim/.vimrc ~/
    vim +PluginInstall +qall

## Git

    cat >> .gitconfig <<EOF

    [include]
    	path = dotfiles/gitconfig
    EOF

## Symlinks

    ln -s ~/dotfiles/ackrc ~/.ackrc
    ln -s ~/dotfiles/flake8 ~/.config/flake8
    ln -s ~/dotfiles/isort.cfg ~/.isort.cfg
    ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/tigrc ~/.tigrc
