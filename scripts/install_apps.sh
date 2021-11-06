#!/bin/bash

set -euxo pipefail

if [ "Darwin" = `uname` ]; then

    open "https://www.spotify.com/download/mac/"

    open "https://www.mozilla.org/en-US/firefox/mac/"
    open "https://www.google.com/chrome/"

    open "https://www.keepassx.org/downloads"
    open "https://www.iterm2.com/"
    open "https://git-fork.com/"

    open "https://www.sublimetext.com/download"

    open "https://desktop.telegram.org/"
    open "https://zoom.us/download"

    # -- macos-specific

    open "https://tunnelblick.net/downloads.html"

    brew install --cask \
        kap \
        keka \
        virtualbox \
        vlc \
        wireshark \
    ;

else
    echo "Unsupported OS"
    exit 1
fi
