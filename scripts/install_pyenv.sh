#!/bin/bash

set -euxo pipefail

# List of build deps:
# https://github.com/pyenv/pyenv/wiki/Common-build-problems

if which brew; then
    brew install \
        pyenv pyenv-virtualenvwrapper \
        python \
        openssl openssl@1.1 \
        readline xz

elif which dnf; then

    sudo dnf install \
        python3-virtualenvwrapper python2-virtualenvwrapper \
        python3 \
        ## compat-openssl10-devel \
        zlib-devel bzip2 bzip2-devel readline-devel \
        sqlite sqlite-devel openssl-devel xz xz-devel libffi-devel

    # https://github.com/pyenv/pyenv-installer
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

    export PATH="${HOME}/.pyenv/bin:$PATH"

    # https://github.com/pyenv/pyenv-virtualenvwrapper
    git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper

else
    echo "Unsupported OS"
    exit 1
fi


cat >> ~/.zshrc << 'EOF'

export PATH="${HOME}/.pyenv/bin:${HOME}/.local/bin:$PATH"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper

# make nvim :checkhealth happy
export PYENV_ROOT=`pyenv root`

EOF

if which brew; then
    cat >> ~/.zshrc << 'EOF'

export CFLAGS="${CFLAGS} -I$(brew --prefix openssl@1.1)/include"
export LDFLAGS="${LDFLAGS} -L$(brew --prefix openssl@1.1)/lib"

export PATH="${HOME}/Library/Python/3.7/bin:$PATH"

EOF
fi


# Running in zsh, which would correctly init pyenv using the code above
cat | zsh -i << 'EOF'

# Apparently installing the latest available Python version
# with pyenv is considered a rocket-science.
# https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv

pyenv install 3.8-dev
pyenv install 3.7.0
pyenv install 3.6.6
pyenv install 3.5.6

pyenv install pypy3.5-6.0.0
pyenv install pypy2.7-6.0.0


# Install openssl 1.0
# https://github.com/pyenv/pyenv/issues/945#issuecomment-317389780
if which brew; then

export CFLAGS="-I$(brew --prefix openssl)/include"
export LDFLAGS="-L$(brew --prefix openssl)/lib"

elif which dnf; then

sudo dnf remove openssl-devel
sudo dnf install compat-openssl10-devel

fi

pyenv install 3.4.0
# 2.7[.0] segfaults on Fedora during installation
pyenv install 2.7.15

if which dnf; then

sudo dnf remove compat-openssl10-devel
sudo dnf install openssl-devel

fi
EOF
