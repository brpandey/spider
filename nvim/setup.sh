#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

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
apply_stow $0
