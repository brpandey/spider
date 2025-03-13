#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

install_package_and_additional "i3" "i3lock picom feh"

# Run additional dependencies related to i3
# which are stored separately for modularity
"$(dirname "$0")/../polybar/setup.sh"
"$(dirname "$0")/../rofi/setup.sh"

apply_stow $0
