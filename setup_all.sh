#!/bin/bash

# Run all modules in proper order

../fonts/setup.sh
../xprofile/setup.sh

# Setup bash customization
../bash/setup.sh

# Editors
../nvim/setup.sh
../spacemacs/setup.sh
../helix/setup.sh

# Window mgr + Terminal multiplexer
../i3/setup.sh
../tmux/setup.sh

# Terminals
../wezterm/setup.sh

# Catch-all
../custom/setup.sh
