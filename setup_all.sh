#!/bin/bash

# Run all modules in proper order

"$(dirname "$0")/fonts/setup.sh"
"$(dirname "$0")/xprofile/setup.sh"

# Setup bash customization
"$(dirname "$0")/bash/setup.sh"

# Editors
"$(dirname "$0")/nvim/setup.sh"
"$(dirname "$0")/spacemacs/setup.sh"
"$(dirname "$0")/helix/setup.sh"

# Window mgr + Terminal multiplexer
"$(dirname "$0")/i3/setup.sh"
"$(dirname "$0")/tmux/setup.sh"

# Terminals
"$(dirname "$0")/wezterm/setup.sh"

# Catch-all
"$(dirname "$0")/custom/setup.sh"
