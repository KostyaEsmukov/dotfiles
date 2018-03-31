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
    pip install --user neovim
    pip3 install --user neovim
    brew install ag
    brew install ctags-exuberant

    # fedora
    sudo dnf install neovim ruby ruby-devel @development-tools redhat-rpm-config the_silver_searcher ctags

    gem install neovim
    mkdir -p ~/.config/nvim/
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.config/nvim/colors/kalisi.vim --create-dirs https://raw.githubusercontent.com/freeo/vim-kalisi/master/colors/kalisi.vim

    # Install fonts and set them in your terminal
    # https://github.com/powerline/fonts/tree/master/Cousine

    ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/
    nvim
    # :PlugInstall
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

## Ack

    ln -s ~/dotfiles/ackrc ~/.ackrc

