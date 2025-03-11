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

# Setup i3 related
../i3/setup.sh
../tmux/setup.sh

../wezterm/setup.sh
