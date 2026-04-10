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
    printf "\n${1}%s${RC}\n" "$2"
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

# installs single package (and also command) $1 without extra msg
install_package_only() {
    if ! command_exists $1; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -y $1
    fi
}

# installs single package (and also command) $1
install_package() {
    if ! command_exists $1; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -y $1
    else
        print_colored "$YELLOW" "Package $1 already exists, no need to install"
    fi
}

# installs package (and also command) $1, and additional $2
install_package_and_additional() {
    if ! command_exists $1; then
        $SUDO_CMD $PACK_MGR update && $SUDO_CMD $PACK_MGR install -y $1 $2
    else
        print_colored "$YELLOW" "Package $1 already exists, no need to install additional $2"
    fi
}

# check cmd $1, if not found install additional $2
check_cmd_install_additional() {
    local trigger="$1"
    
    if ! command_exists "$trigger"; then
        $SUDO_CMD $PACK_MGR update && \
        $SUDO_CMD $PACK_MGR install -y "$@"
    else
        print_colored "$YELLOW" "Cmd $trigger already exists, no need to install additional $2"
    fi
}

# Flexible function to add APT repositories with GPG keys
add_apt_repo() {
    local key_url="$1"
    local key_file="$2"
    local repo_url="$3"
    local list_file="$4"

    echo "Adding GPG key from $key_url..."
    curl -fsSL "$key_url" | sudo gpg --yes --dearmor -o "/usr/share/keyrings/$key_file"

    echo "Adding APT repository $repo_url..."
    echo "deb [signed-by=/usr/share/keyrings/$key_file] $repo_url * *" | sudo tee "/etc/apt/sources.list.d/$list_file"

    echo "Setting permissions for the key..."
    sudo chmod 644 "/usr/share/keyrings/$key_file"

    echo "Updating package lists..."
    sudo apt update

    echo "Repository $repo_url added successfully!"
}
