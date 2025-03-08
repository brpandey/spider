#!/bin/bash

RC=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

SUDO_CMD="sudo"
PACK_MGR="apt"

# Helper functions
print_colored() {
    printf "${1}%s${RC}\n" "$2"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"
echo $SPIDER_PATH

install_packages() {
    if ! command_exists xcape; then
        ${SUDO_CMD} ${PACK_MGR} install -yq xcape
    else
        print_colored "$YELLOW" "Package already exists, no need to install"
    fi
}

apply_stow() {
    if ! stow -vt ~ -d $SPIDER_PATH $MODULE_NAME; then
        print_colored "$RED" "Unable to apply stow properly"
    else
        print_colored "$GREEN" "Stow run successfully"
    fi
}

install_packages
apply_stow
