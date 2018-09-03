#!/bin/bash

# This script must be idempotent

set -euxo pipefail

sudo dnf install fedora-workstation-backgrounds \
    arc-theme \
    gnome-tweak-tool \
    gnome-themes-standard \
    chrome-gnome-shell


if [ ! -d ~/.icons/Arc-OSX-D ]; then
    pushd ~/Downloads
    wget https://gitlab.com/LinxGem33/Arc-X-Icons/-/archive/master/Arc-X-Icons-master.tar.gz
    tar xaf Arc-X-Icons-master.tar.gz
    mkdir -p ~/.icons
    mv Arc-X-Icons-master/src/* ~/.icons/
    rm -Rf Arc-X-Icons-master*
    popd
fi


mkdir -p ~/.local/share/gnome-shell/extensions
echo "Opening Chromium window with the Gnome extensions to install..."
chromium-browser \
    https://extensions.gnome.org/extension/2/move-clock/ \
    https://extensions.gnome.org/extension/258/notifications-alert-on-user-menu/ \
    https://extensions.gnome.org/extension/307/dash-to-dock/ \
    https://extensions.gnome.org/extension/495/topicons/ \
    https://extensions.gnome.org/extension/708/panel-osd/ \
    https://extensions.gnome.org/extension/723/pixel-saver/ \
    https://extensions.gnome.org/extension/1037/customcorner/ \
    https://extensions.gnome.org/extension/1236/noannoyance/ \
    https://extensions.gnome.org/extension/1253/extended-gestures/ \
    ''

