#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

EMACS="emacs"
SPACEMACS_LINK="$HOME/.spacemacs"
SPACEMACS_URL="https://github.com/syl20bnr/spacemacs"
SPACEMACS_TARGET="$HOME/.emacs.d"

install_spacemacs() {
    # if SPACEMACS_LINK exists and is a valid file, don't re-install extra packages
    if [ ! -L "$SPACEMACS_LINK" ]; then
        install_package $EMACS
        # Note: Uninstall emacs with:
        # sudo apt remove --purge emacs-bin-common emacs-el emacs-gtk

        # Move existing emacs config to backup
        mv "$HOME/.emacs" "$HOME.emacs.bak"
        mv "$HOME/.emacs.d" "$HOME.emacs.d.bak"

        git clone --recurse-submodules $SPACEMACS_URL $SPACEMACS_TARGET
    else
        print_colored "$YELLOW" "$SPACEMACS_LINK already exists, no need to install again. If so desired, remove symbolic link"
    fi
}

install_spacemacs
apply_stow $0
