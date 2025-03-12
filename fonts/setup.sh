#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

update_font_cache() {
    fc-cache -fv
}

update_font_cache
apply_stow $0
