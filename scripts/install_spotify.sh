#!/bin/bash

set -euxo pipefail

if [ "Darwin" = `uname` ]; then

    open "https://www.spotify.com/int/download/mac/"

elif which dnf; then

    # https://www.spotify.com/int/download/linux/

    # TODO maybe use flatpak instead?

    sudo dnf install snapd

    snap install spotify
    snap enable spotify
    # snap run spotify


    # https://community.spotify.com/t5/Desktop-Linux/Linux-client-barely-usable-on-HiDPI-displays/td-p/1067272/page/6
    sudo perl -i -p0e \
        's/spotify %U/spotify --force-device-scale-factor=2.0 %U/gs'
        /var/lib/snapd/desktop/applications/spotify_spotify.desktop
else
    echo "Unsupported OS"
    exit 1
fi
