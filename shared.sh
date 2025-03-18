#!/bin/bash

# https://www.linuxcommand.org/lc3_adv_tput.php
RC=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)

SUDO_CMD="sudo"
PACK_MGR="apt"

# Helper functions
print_colored() {
    printf "${1}%s${RC}\n" "$2"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

greeting() {
    MODULE_NAME=$(basename $(dirname "$(realpath "$1")"))
    print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"
}

# Run additional dependencies from peer spider module directory bash script
# E.g. run_peer_dependency_sh $0 "starship/setup.sh"
run_peer_dependency_sh() {
    "$(dirname "$(realpath "$1")")/../"$2""
}

stow_check_apply() {
    local spider_dir="$1" # Directory containing the stow packages
    local package="$2"    # The specific package to be stowed
    STOW_SUCCESS_TOKEN="LINK"

    # Run the dry-run command and capture the output,
    # stow outputs to stderr so switch it to stdout
    local grep_output=$(stow -nvt ~ -d "$spider_dir" "$package" 2>&1 | grep "$STOW_SUCCESS_TOKEN")

    # Now check if grep found the LINK token indicating success during simulation mode
    # If found, it means stow can successfully create a symbolic link
    # So run again without simulate flag
    if [[ -n "$grep_output" ]]; then
        if stow -vt ~ -d "$spider_dir" "$package"; then
            print_colored "$GREEN" "Stow applied"
        else
            print_colored "$RED" "Unable to apply stow properly"
        fi
    else
        print_colored "$YELLOW" "Stow already applied, no changes made"
    fi
}

apply_stow() {
    MODULE_PATH=$(dirname "$(realpath "$1")")
    MODULE_NAME=$(basename $MODULE_PATH)
    SPIDER_PATH=$(dirname $MODULE_PATH)

    stow_check_apply $SPIDER_PATH $MODULE_NAME
}

# installs single package (and also command) $1
install_package() {
    if ! command_exists $1; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq $1
    else
        print_colored "$YELLOW" "Package $1 already exists, no need to install"
    fi
}

# installs package (and also command) $1, and additional $2
install_package_and_additional() {
    if ! command_exists $1; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq $1 $2
    else
        print_colored "$YELLOW" "Package $1 already exists, no need to install additional $2"
    fi
}

# check cmd $1, if not found install additional $2
check_cmd_install_additional() {
    if ! command_exists $1; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq $2
    else
        print_colored "$YELLOW" "Cmd $1 already exists, no need to install additional $2"
    fi
}

# check link $1, if not found install additional
check_link_install_additional() {
    if [[ ! -L $1 ]]; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -yq $2
    else
        print_colored "$YELLOW" "Link $1 already exists, no need to install additional $2"
    fi
}
