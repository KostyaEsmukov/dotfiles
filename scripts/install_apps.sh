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

else
    echo "Unsupported OS"
    exit 1
fi
