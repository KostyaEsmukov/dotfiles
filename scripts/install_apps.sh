#!/bin/bash

set -euxo pipefail

if [ "Darwin" = `uname` ]; then

_install_common() {
    open "https://www.spotify.com/download/mac/"

    open "https://www.mozilla.org/en-US/firefox/mac/"
    open "https://www.google.com/chrome/"

    open "https://www.keepassx.org/downloads"
    open "https://git-fork.com/"

    open "https://www.sublimetext.com/download"

    open "https://zoom.us/download"

    brew install --cask \
        ghostty \
        gimp \
        hex-fiend \
        kap \
        keka \
        vlc \
        wireshark \
    ;

    if [ "x86_64" = `uname -m` ]; then
        brew install --cask \
            virtualbox \
        ;
    fi

    brew install \
        awscli \
        clickhouse \
        docker \
        docker-compose \
        libpq \
        fswatch \
    ;

    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
}

_install_home() {
    open "https://desktop.telegram.org/"
    open "https://www.dropbox.com/install"
    open "https://www.office.com/"
    open "https://www.yubico.com/support/download/yubikey-manager/"

    open "https://apps.apple.com/ru/app/microsoft-remote-desktop/id1295203466?l=en&mt=12"
    open "https://apps.apple.com/ru/app/pine-player/id1112075769?l=en&mt=12"
    open "https://apps.apple.com/ru/app/pipifier/id1160374471?l=en&mt=12"
    open "https://apps.apple.com/us/app/outline-secure-internet-access/id1356178125?mt=12"

    brew install --cask \
        iina \
        tor-browser \
        transmission \
        tunnelblick \
    ;
}

_install_work() {
    brew install --cask \
        finicky \
        google-drive \
        openlens \
        thunderbird \
    ;
    brew install \
        git-filter-repo \
        git-lfs \
        kubernetes-cli \
        wrk \
        yq \
    ;
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
