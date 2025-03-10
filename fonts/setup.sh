#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

update_font_cache() {
    fc-cache -fv
}

apply_stow $SPIDER_PATH $MODULE_NAME

# after stow has been applied, update font cache
update_font_cache
