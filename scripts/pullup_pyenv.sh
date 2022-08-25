#!/bin/bash

set -euxo pipefail

# List of build deps:
# https://github.com/pyenv/pyenv/wiki/Common-build-problems

if which brew; then
    # https://docs.brew.sh/Homebrew-and-Python
    brew install \
        pyenv pyenv-virtualenv \
        python \
        openssl openssl@1.1 \
        readline xz bzip2

else
    sudo apt install \
        libreadline-dev libbz2-dev libssl-dev libsqlite3-dev libffi-dev liblzma-dev
    if ! which pyenv >/dev/null 2>&1; then
        curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash -x
    fi
fi

if which brew; then
    if ! grep -q PYVER ~/.zshrc; then
        cat >> ~/.zshrc << 'EOF'

PYVER=`/usr/local/bin/python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])), end="")'`
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

# Apparently installing the latest available Python version
# with pyenv is considered a rocket-science.
# https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv

# Show available versions: `pyenv install --list`
pyenv install 3.10.6
pyenv install 3.9.13
pyenv install 3.8.13
pyenv install 3.7.13

# https://github.com/pyenv/pyenv/issues/1740#issuecomment-931540317
export CFLAGS="-I$(brew --prefix openssl@1.1)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include"
export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib"

pyenv install --patch 3.6.15 < <(curl -sSL 'https://github.com/python/cpython/commit/8ea6353.patch?full_index=1')
pyenv install --patch 3.5.10 < <(curl -sSL 'https://github.com/python/cpython/commit/8ea6353.patch?full_index=1')

pyenv install pypy3.7-7.3.7


# Link against openssl 1.0
# https://github.com/pyenv/pyenv/issues/945#issuecomment-317389780
export CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl@1.1)/include"
export LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl@1.1)/lib"

# https://github.com/pyenv/pyenv-virtualenv/issues/401#issuecomment-907693650
pyenv install 2.7.18 && pyenv shell 2.7.18 && python -m pip install --upgrade --force-reinstall virtualenv

cd ~
rm .python-version

EOF
