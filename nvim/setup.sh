#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

CMD=nvim
NVIM_TARGET_DIR="/opt"
ADDITIONAL="npm python3-venv" # Note: Nvim mason (linting, lsp, formatting, dap) needs npm and python virtual environment

install_neovim() {
    if ! command_exists $CMD; then
        ${SUDO_CMD} ${PACK_MGR} install -yq $ADDITIONAL

        if ! curl -L https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz | $SUDO_CMD tar -xz -C $NVIM_TARGET_DIR; then
            print_colored "$RED" "Something went wrong during $CMD install!"
            exit 1
        fi
    else
        printf "$CMD already installed\n"
    fi
}

install_neovim
apply_stow $SPIDER_PATH $MODULE_NAME
