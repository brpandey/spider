#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0


# install_helix
install_package "hx"
apply_stow $0
