#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

# Include additional packages for use in the command line
CLI_TOOLS=(gawk stow git curl wget make bat trash-cli eza fzf 
    ripgrep gedit okular ranger htop gnome-software gnome-tweaks
    rename libfuse2t64 krop gparted stacer okular imagemagick pdftk) # tldr

install_cli_tools() {
    echo "About to install CLI Tools"
    check_cmd_install_additional "${CLI_TOOLS[@]}"
    echo "Finished installing CLI Tools"
}

install_cli_tools
