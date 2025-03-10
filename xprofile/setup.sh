#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

install_packages() {
    if ! command_exists xcape; then
        ${SUDO_CMD} ${PACK_MGR} install -yq xcape
    else
        print_colored "$YELLOW" "Package already exists, no need to install"
    fi
}

install_packages
apply_stow $SPIDER_PATH $MODULE_NAME
