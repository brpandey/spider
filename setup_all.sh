#!/bin/bash

# Run all modules in proper order
PREFIX="$(dirname "$0")"

"$PREFIX/fonts/setup.sh"
"$PREFIX/xprofile/setup.sh"

# Setup bash customization
"$PREFIX/bash/setup.sh"

# Editors
"$PREFIX/nvim/setup.sh"
"$PREFIX/spacemacs/setup.sh"
"$PREFIX/helix/setup.sh"

# Window mgr + Terminal multiplexer
"$PREFIX/i3/setup.sh"
"$PREFIX/tmux/setup.sh"

# Terminals
"$PREFIX/wezterm/setup.sh"

# Docker
"$PREFIX/docker/setup.sh"

# Catch-all
"$PREFIX/custom/setup.sh"
