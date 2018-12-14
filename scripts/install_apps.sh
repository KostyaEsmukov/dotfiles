#!/bin/bash

set -euxo pipefail

# TODO (?) telegram, firefox dev ed, redis

if [ "Darwin" = `uname` ]; then

    open "https://www.google.com/chrome/"
    open "https://www.keepassx.org/downloads"
    open "https://www.iterm2.com/"
    open "https://git-fork.com/"

    open "https://www.sublimetext.com/3"

    open "https://postgresapp.com/"

    open "https://www.virtualbox.org/wiki/Downloads"
    open "https://www.wireshark.org/download.html"

    # -- macos-specific

    open "https://www.keka.io/"
    open "https://tunnelblick.net/downloads.html"

elif which dnf; then

    sudo dnf install \
        chromium \
        keepassx \
        tilix

    # https://www.sublimetext.com/docs/3/linux_repositories.html#dnf
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    sudo dnf install sublime-text
    sudo dnf install sublime-merge

    sudo dnf install postgresql-server postgresql-contrib
    sudo postgresql-setup --initdb --unit postgresql
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

    # For VLC and VirtualBox
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    sudo dnf install \
        VirtualBox \
        wireshark

    # -- Linux-specific

    # A mail client
    sudo dnf install evolution

    # VLC also installs a bunch of codecs, used by browsers for playing html5 videos.
    # https://www.videolan.org/vlc/download-fedora.html
    sudo dnf install vlc

else
    echo "Unsupported OS"
    exit 1
fi
