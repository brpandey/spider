#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

# Include additional packages for use in the command line
ADDITIONAL="gawk git make bat trash-cli tldr eza fzf ripgrep ranger"
BASH_LINK="$HOME/.bashrc"
BLESH_FPATH="$HOME/.local/share/blesh/ble.sh"

install_packages() {
    # if BASH_LINK exists and is a valid file, don't re-install extra packages
    if [[ -L "$BASH_LINK" ]]; then
        print_colored "$YELLOW" "$BASH_LINK already exists, no need to install extra packages"
    else
        ${SUDO_CMD} ${PACK_MGR} install -yq $ADDITIONAL
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
        print_colored "$YELLOW" "Already installed at $BLESH_FPATH"
    fi
}

install_zoxide() {
    if ! command_exists zoxide; then
        if ! curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
            print_colored "$RED" "Something went wrong during zoxide install!"
            exit 1
        fi
    else
        printf "Zoxide already installed\n"
    fi
}

install_packages
install_blesh
install_zoxide
apply_stow $SPIDER_PATH $MODULE_NAME
