#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

CMD="hx"

install_helix() {
    if ! command_exists $CMD; then
        print_colored "$GREEN" "Adding helix ppa"
        $SUDO_CMD add-apt-repository ppa:maveonair/helix-editor
        check_cmd_install_additional $CMD "helix"
    else
        print_colored "$YELLOW" "Package helix already exists, no need to install"
    fi
}

install_helix
apply_stow $0
