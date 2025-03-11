#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

install_package_and_additional "i3" "i3lock picom feh"
apply_stow $SPIDER_PATH $MODULE_NAME

# Run additional dependencies related to i3
# which are stored separately for modularity
../polybar/setup.sh
../rofi/setup.sh
