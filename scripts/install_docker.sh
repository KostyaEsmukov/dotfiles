#!/bin/bash

set -euxo pipefail

if [ "Darwin" = `uname` ]; then

    brew install --cask docker

elif which apt; then

    sudo apt update
    sudo apt install --no-install-recommends docker.io docker-compose

    sudo gpasswd -a `whoami` docker
else
    echo "Unsupported OS"
    exit 1
fi

