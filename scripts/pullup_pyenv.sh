#!/bin/bash

set -euxo pipefail

# List of build deps:
# https://github.com/pyenv/pyenv/wiki/Common-build-problems

if which brew; then
    # https://docs.brew.sh/Homebrew-and-Python
    brew install \
        pyenv pyenv-virtualenv \
        python \
        openssl \
        readline xz bzip2

else
    sudo -E apt install \
        build-essential \
        libbz2-dev \
        libffi-dev \
        liblzma-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        make \
    ;
    if ! which pyenv >/dev/null 2>&1; then
        curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash -x
    fi
fi

if which brew; then
    if ! grep -q PYVER ~/.zshrc; then
        cat >> ~/.zshrc << 'EOF'

PYVER=`/opt/homebrew/bin/python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])), end="")'`
export PATH="${HOME}/Library/Python/${PYVER}/bin:$PATH"

eval "$(pyenv init --path)"

EOF
    fi
else
    if ! grep -q PYENV_ROOT ~/.zshrc; then
        cat >> ~/.zshrc << 'EOF'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

EOF
    fi
fi

# Fix for `ImportError: No module named pyexpat`:
#   export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk
#
# See also: https://stackoverflow.com/a/62827571



# Running in zsh, which would correctly init pyenv using the code above
zsh -ls < /dev/null << 'EOF' || true
source ~/.zshrc

# Show available versions: `pyenv install --list`
pyenv install 3.12:latest
pyenv install 3.8:latest

cd ~
rm .python-version

EOF
