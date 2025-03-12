#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

# Include additional packages for use in the command line
ADDITIONAL="gawk git make bat trash-cli tldr eza fzf ripgrep ranger"
BASH_LINK="$HOME/.bashrc"
BLESH_FPATH="$HOME/.local/share/blesh/ble.sh"

install_packages() {
    # if BASH_LINK exists and is a valid file, don't re-install extra packages
    if [[ ! -L "$BASH_LINK" ]]; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq $ADDITIONAL
    else
        print_colored "$YELLOW" "$BASH_LINK already exists, no need to install extra packages"
    fi
}

# fish is really cool, but bash also has ble.sh
install_blesh() {
    # if blesh path not found, then clone ble.sh to temp dir and install locally
    if [[ ! -f "$BLESH_FPATH" ]]; then
        TEMP_DIR=$(mktemp -d)
        git -C $TEMP_DIR clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
        cd $TEMP_DIR && make -C ble.sh install PREFIX=~/.local
    else
        print_colored "$YELLOW" "ble.sh already exists at $BLESH_FPATH"
    fi
}

install_zoxide() {
    if ! command_exists zoxide; then
        if ! curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
            print_colored "$RED" "Something went wrong during zoxide install!"
            exit 1
        fi
    else
        print_colored "$YELLOW" "Zoxide already installed"
    fi
}

install_packages
install_blesh
install_zoxide

# Run additional dependencies related to bash
# which are stored separately for modularity
../starship/setup.sh

apply_stow $0
