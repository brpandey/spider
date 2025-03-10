#!/bin/bash

RC=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

SUDO_CMD="sudo"
PACK_MGR="apt"

# Helper functions
print_colored() {
    printf "${1}%s${RC}\n" "$2"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

apply_stow() {
    if ! stow -vt ~ -d $1 $2; then
        print_colored "$RED" "Unable to apply stow properly"
    else
        print_colored "$GREEN" "Stow run successfully"
    fi
}
