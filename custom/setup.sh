#!/bin/bash

MODULE_PATH=$(dirname "$(realpath "$0")")
MODULE_NAME=$(basename $MODULE_PATH)
SPIDER_PATH=$(dirname $MODULE_PATH)

# Pull in shared top-level functions and variables
source "$SPIDER_PATH/shared.sh"

print_colored "$GREEN" "Setting up $MODULE_NAME (spider) module"

TRASH_RM=trash
ELIXIRLS_TARGET="$HOME/.local/share"
ELIXIRLS_RELEASE="$ELIXIRLS_TARGET/elixir-ls/release"

install_elixirls() {
    if [ ! -L $ELIXIRLS_RELEASE/elixir-ls ]; then
        git -C $ELIXIRLS_TARGET clone git@github.com:elixir-lsp/elixir-ls.git
        cd "$ELIXIRLS_TARGET/elixir-ls"
        print_colored "$GREEN" "About to run mix deps.get to pull down dependencies"

        mix deps.get
        mkdir $ELIXIRLS_RELEASE
        print_colored "$GREEN" "Created release directory"

        export MIX_ENV=prod
        print_colored "$GREEN" "Running mix elixir_ls.release2"
        mix elixir_ls.release2 -0 elixir-ls
        env | grep MIX_ENV

        cd $ELIXIRLS_RELEASE
        ls $ELIXIRLS_RELEASE

        print_colored "$GREEN" "Symbolic linking language server sh executable to more concise name: elixir-ls"
        ln -s $ELIXIRLS_RELEASE/language_server.sh $ELIXIRLS_RELEASE/elixir-ls

        print_colored "$GREEN" "Running initial invocation of elixir-ls, press <ENTER> when done"
        $ELIXIRLS_RELEASE/./elixir-ls
    else
        print_colored "$YELLOW" "elixir-ls sh script already exists, no need to re-install"
    fi
}

# Install Elixir language server since Helix (and apparently Neovim now can) doesn't seem to be able to do so automatically
install_elixirls

# Not stowing at this time, just installing
