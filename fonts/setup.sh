#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

update_font_cache() {
    if [ -L "$HOME/.fonts" ]; then
        fc-cache -f # optionally can add -fv as well for verbose
    fi
}

apply_stow $0
update_font_cache
