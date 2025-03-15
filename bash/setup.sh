#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

# Include additional packages for use in the command line
CLI_TOOLS="gawk git curl wget make bat trash-cli tldr eza fzf ripgrep ranger gnome-tweak-tool"
BASH_LINK="$HOME/.bashrc"
BLESH_FPATH="$HOME/.local/share/blesh/ble.sh"

install_cli_tools() {
    # if BASH_LINK exists and is a valid file, don't re-install extra packages
    check_link_install_additional "$BASH_LINK" "$CLI_TOOLS"
}

# fish is really cool, but bash also has ble.sh
install_blesh() {
    # if blesh path not found, then clone ble.sh to temp dir and install locally
    if [[ ! -f "$BLESH_FPATH" ]]; then
        TEMP_DIR=$(mktemp -d)
        git -C $TEMP_DIR clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
        cd $TEMP_DIR && make -C ble.sh install PREFIX=~/.local
    else
        print_colored "$YELLOW" "ble.sh already installed"
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

install_cli_tools
install_blesh
install_zoxide

# Run additional dependencies related to bash
# which are stored separately for modularity
run_peer_dependency_sh $0 "starship/setup.sh"

apply_stow $0
