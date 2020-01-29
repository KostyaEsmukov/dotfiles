#!/bin/bash

set -euxo pipefail

if [ "Darwin" = `uname` ]; then

    brew cask install docker

elif which dnf; then

    # https://docs.docker.com/install/linux/docker-ce/fedora/

    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo

    sudo dnf install docker-ce
    sudo systemctl start docker
    sudo systemctl enable docker

    sudo gpasswd -a `whoami` docker

elif which apt; then

    # https://docs.docker.com/install/linux/docker-ce/debian/

    if [ "x86_64" != `uname -m` ]; then
        echo "This script is for x86_64 only."
        echo "Please install docker manually instead."
        exit 1
    fi

    if [ "Debian" != `lsb_release -si` ]; then
        echo "This script is for Debian."
        echo "Please install docker manually instead."
        exit 1
    fi

    sudo apt install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"

    sudo apt update
    sudo apt install docker-ce

    sudo gpasswd -a `whoami` docker
else
    echo "Unsupported OS"
    exit 1
fi

