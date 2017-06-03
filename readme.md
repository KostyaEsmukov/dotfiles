# dotfiles (MacOS)

    git clone https://github.com/KostyaEsmukov/dotfiles.git ~/dotfiles

## Neovim

    brew tap neovim/neovim
    brew tap rogual/neovim-dot-app
    brew install neovim-dot-app
    brew linkapps neovim-dot-app

    pip install neovim
    pip3 install neovim
    gem install neovim
    brew install ag
    brew install ctags-exuberant

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.config/nvim/colors/kalisi.vim --create-dirs https://raw.githubusercontent.com/freeo/vim-kalisi/master/colors/kalisi.vim

    mkdir -p ~/.config/nvim/
    ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/

## Vim

    brew install vim
    brew link vim

    ln -sv ~/dotfiles/vim/.vimrc ~/

## Zsh + oh-my-zh

    source ~/dotfiles/zshrc/ohmyzsh
    # source $ZSH/oh-my-zsh.sh
    source ~/dotfiles/zshrc/zshrc

