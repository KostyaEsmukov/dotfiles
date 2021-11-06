#!/bin/bash

set -euxo pipefail

if [ "Darwin" = `uname` ]; then

_install_common() {
    open "https://www.spotify.com/download/mac/"

    open "https://www.mozilla.org/en-US/firefox/mac/"
    open "https://www.google.com/chrome/"

    open "https://www.keepassx.org/downloads"
    open "https://www.iterm2.com/"
    open "https://git-fork.com/"

    open "https://www.sublimetext.com/download"

    open "https://tunnelblick.net/downloads.html"

    brew install --cask \
        kap \
        keka \
        vlc \
    ;
}

_install_home() {
    open "https://desktop.telegram.org/"
    open "https://www.dropbox.com/install"
    open "https://www.office.com/"
    open "https://www.yubico.com/support/download/yubikey-manager/"

    brew install --cask \
        evernote \
        iina \
        tor-browser \
        transmission \
        virtualbox \
        wireshark \
    ;

    open "https://apps.apple.com/ru/app/microsoft-remote-desktop/id1295203466?l=en&mt=12"
    open "https://apps.apple.com/ru/app/pine-player/id1112075769?l=en&mt=12"
    open "https://apps.apple.com/ru/app/pipifier/id1160374471?l=en&mt=12"
}

_install_work() {
    open "https://zoom.us/download"
}

else
    echo "Unsupported OS"
    exit 1
fi


case "$1" in
  home)
    _install_common
    _install_home
    ;;
  work)
    _install_common
    _install_work
    ;;
  *)
    echo Unknown type
    exit 1
    ;;
esac
