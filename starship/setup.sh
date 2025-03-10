#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

install_starship() {
    if ! command_exists starship; then
        if ! curl -sS https://starship.rs/install.sh | sh; then
            print_colored "$RED" "Something went wrong during starship install!"
            exit 1
        fi
    else
        printf "Starship already installed\n"
    fi
}

install_starship
apply_stow $SPIDER_PATH $MODULE_NAME
