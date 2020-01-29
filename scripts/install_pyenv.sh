#!/bin/bash

set -euxo pipefail

# List of build deps:
# https://github.com/pyenv/pyenv/wiki/Common-build-problems

if which brew; then
    # https://docs.brew.sh/Homebrew-and-Python
    brew install \
        pyenv pyenv-virtualenv pyenv-virtualenvwrapper \
        python python@2 \
        openssl openssl@1.1 \
        readline xz

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

export CFLAGS="${CFLAGS} -I$(brew --prefix readline)/include -I$(brew --prefix openssl@1.1)/include"
export LDFLAGS="${LDFLAGS} -L$(brew --prefix readline)/lib -L$(brew --prefix openssl@1.1)/lib"

export PATH="${HOME}/Library/Python/3.7/bin:$PATH"

EOF
fi


# Running in zsh, which would correctly init pyenv using the code above
cat | zsh -ls << 'EOF' || true
source ~/.zshrc
deactivate

# Apparently installing the latest available Python version
# with pyenv is considered a rocket-science.
# https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv

pyenv install 3.9-dev
pyenv install 3.8.0
pyenv install 3.7.4
pyenv install 3.6.9
pyenv install 3.5.7

pyenv install pypy3.6-7.1.1
pyenv install pypy2.7-7.1.1


# Install openssl 1.0
# https://github.com/pyenv/pyenv/issues/945#issuecomment-317389780
if which brew; then

export CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include"
export LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib"

fi

pyenv install 3.4.10
pyenv install 2.7.16

EOF
