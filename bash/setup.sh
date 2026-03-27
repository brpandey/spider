#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

# Include additional packages for use in the command line
# https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration
CLI_TOOLS="gawk git curl wget make bat trash-cli eza fzf ripgrep gedit ranger gnome-tweak-tool" # tldr
BLESH_FPATH="$HOME/.local/share/blesh/ble.sh"

install_cli_tools() {
    echo "About to install CLI Tools"
    check_cmd_install_additional "gawk" "$CLI_TOOLS"
    echo "Finished installing CLI Tools"
}

# fish is really cool, but bash also has ble.sh
install_blesh() {
    # if blesh path not found, then clone ble.sh to temp dir and install locally
    if [[ ! -f "$BLESH_FPATH" ]]; then
	pushd "."
        TEMP_DIR=$(mktemp -d)
        git -C $TEMP_DIR clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
        cd $TEMP_DIR && make -C ble.sh install PREFIX=~/.local
	popd
    else
        print_colored "$YELLOW" "ble.sh already installed"
    fi
}

install_zoxide() {
    if ! command_exists zoxide; then
        if ! curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
            print_colored "$RED" "Something went wrong during zoxide install!"
            exit 1
        fi
    else
        print_colored "$YELLOW" "Zoxide already installed"
    fi
}

backup_bashrc() {
# If bash_aliases is not present while bashrc is present and not a symlink (already stowed)
# then backup as _default
    if [ ! -f "$HOME/.bash_aliases" ] && [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
      if [ ! -f "$HOME/.bashrc_default" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc_default"
        echo "Backed up .bashrc to .bashrc_default"
      fi
    fi
}

install_cli_tools
install_blesh
install_zoxide

# Run additional dependencies related to bash
# which are stored separately for modularity

run_peer_dependency_sh $0 "starship/setup.sh"

backup_bashrc

apply_stow $0
