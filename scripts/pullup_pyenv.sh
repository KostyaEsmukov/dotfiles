#!/bin/bash

set -euxo pipefail

if ! which pyenv; then
    # List of build deps:
    # https://github.com/pyenv/pyenv/wiki/Common-build-problems

    if which brew; then
        # https://docs.brew.sh/Homebrew-and-Python
        brew install \
            pyenv pyenv-virtualenv pyenv-virtualenvwrapper \
            python \
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

fi

# Fix for `ImportError: No module named pyexpat`:
#   export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk
#
# See also: https://stackoverflow.com/a/62827571



# Running in zsh, which would correctly init pyenv using the code above
cat | zsh -ls << 'EOF' || true
source ~/.zshrc
deactivate

# Apparently installing the latest available Python version
# with pyenv is considered a rocket-science.
# https://stackoverflow.com/questions/29687140/install-latest-python-version-with-pyenv

pyenv install 3.10.0rc1
pyenv install 3.9.6
pyenv install 3.8.11
pyenv install 3.7.11
pyenv install 3.6.14
pyenv install 3.5.10

pyenv install pypy3.6-7.3.3
pyenv install pypy2.7-7.3.1


# Link against openssl 1.0
# https://github.com/pyenv/pyenv/issues/945#issuecomment-317389780
export CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include"
export LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib"

pyenv install 2.7.18

cd ~
pyenv local 3.8.11

exit
EOF
