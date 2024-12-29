#!/bin/bash

set -euxo pipefail

if which brew; then

    brew install zsh \
        mozjpeg \
        jpegoptim \
        exiftool \
        imagemagick

    sudo sh -c "echo `which zsh` >> /etc/shells"
    chsh -s `which zsh`

    brew install fzf
    $(brew --prefix)/opt/fzf/install

elif which apt; then

    sudo -E apt install zsh \
        libjpeg-turbo-progs \
        jpegoptim \
        libimage-exiftool-perl \
        imagemagick

    # https://github.com/junegunn/fzf#using-git
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    sudo usermod -s `which zsh` `whoami`
else
    echo "Unsupported OS"
    exit 1
fi

# https://github.com/robbyrussell/oh-my-zsh#basic-installation
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Make .zshrc look like this:
# source ~/dotfiles/zshrc/ohmyzsh
# source $ZSH/oh-my-zsh.sh
# source ~/dotfiles/zshrc/zshrc

perl -i -p0e \
    's#(source \$ZSH/oh-my-zsh.sh)#source ~/dotfiles/zshrc/ohmyzsh\n${1}\nsource ~/dotfiles/zshrc/zshrc#igs' \
    ~/.zshrc

if [ ! -f ~/.rsync_watch_excludes ]; then
    cp ~/dotfiles/rsync_watch_excludes.initial ~/.rsync_watch_excludes
fi

touch ~/.z
