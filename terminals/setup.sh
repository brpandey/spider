#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0


add_apt_repo \
    "https://apt.fury.io/wez/gpg.key" \
    "wezterm-fury.gpg" \
    "https://apt.fury.io/wez/" \
    "wezterm.list"

install_package "wezterm"
install_package "kitty"
apply_stow $0


