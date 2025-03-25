#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

install_ollama() {
    if ! command_exists ollama; then
        if ! curl -fsSL https://ollama.com/install.sh | sh; then
            print_colored "$RED" "Something went wrong during starship install!"
            exit 1
        fi
    else
        printf "Ollama already installed\n"
    fi
}

install_ollama
# apply_stow $0
