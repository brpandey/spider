#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"
TRASH_RM=trash

install_helix() {
    if ! command_exists hx; then
        $SUDO_CMD add-apt-repository ppa:maveonair/helix-editor
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq helix
        $TRASH_RM "$HOME/.config/helix"
    else
        print_colored "$YELLOW" "Package helix already exists, no need to install"
    fi
}

install_helix
apply_stow $SPIDER_PATH $MODULE_NAME
