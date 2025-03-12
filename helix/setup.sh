#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

install_helix() {
    if ! command_exists hx; then
        $SUDO_CMD add-apt-repository ppa:maveonair/helix-editor
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq helix
    else
        print_colored "$YELLOW" "Package helix already exists, no need to install"
    fi
}

install_helix
apply_stow $0
