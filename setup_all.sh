#!/bin/bash

# Run all modules in proper order
PREFIX="$(dirname "$0")"

# Setup basic command line tools
"$PREFIX/cli-tools/setup.sh"

"$PREFIX/fonts/setup.sh"
"$PREFIX/xprofile/setup.sh"

# Setup bash customization
"$PREFIX/bash/setup.sh"

# Editors
"$PREFIX/nvim/setup.sh"
"$PREFIX/spacemacs/setup.sh"
#"$PREFIX/helix/setup.sh"

# Window mgr + Terminal multiplexer
"$PREFIX/i3/setup.sh"
"$PREFIX/tmux/setup.sh"

# Terminals
"$PREFIX/terminals/setup.sh"

# Commented out these sections to allow these to be run later and individually as needed
# Languages
# "$PREFIX/languages/setup.sh"

# Dev Tools
# "$PREFIX/dev-tools/setup.sh"

# Docker
# "$PREFIX/docker/setup.sh"
