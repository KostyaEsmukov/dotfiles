# dotfiles (MacOS + Debian headless)

    git clone https://github.com/KostyaEsmukov/dotfiles.git ~/dotfiles
    # or
    git clone git@github.com:KostyaEsmukov/dotfiles.git ~/dotfiles

## Installation scripts

    # Terminal utils (usable on headless machines too!)
    ~/dotfiles/scripts/pullup_utils.sh
    ~/dotfiles/scripts/install_zsh.sh
    ~/dotfiles/scripts/pullup_links.sh
    ~/dotfiles/scripts/pullup_vim.sh
    ~/dotfiles/scripts/install_docker.sh

    # GUI apps
    ~/dotfiles/scripts/install_apps.sh home|work

    # Re-create the shell session
    ~/dotfiles/scripts/pullup_pyenv.sh
    # Re-create the shell session
    ~/dotfiles/scripts/install_git_ssh.sh
    ~/dotfiles/scripts/pullup_nvim.sh

    # VM preferences
    # Allow the terminal app to have full disk access first.
    ~/dotfiles/scripts/pullup_macos_defaults.sh
