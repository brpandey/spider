#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

ELIXIRLS_TARGET="$HOME/.local/share"
ELIXIRLS_RELEASE="$ELIXIRLS_TARGET/elixir-ls/release"
ELIXIRLS_GIT_REPO="git@github.com:elixir-lsp/elixir-ls.git"
NAME="elixir-ls"

install_elixirls() {
    if [ ! -L "$ELIXIRLS_RELEASE/$NAME" ]; then
        git -C $ELIXIRLS_TARGET clone $ELIXIRLS_GIT_REPO
        cd "$ELIXIRLS_TARGET/$NAME"
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

        print_colored "$GREEN" "Symbolic linking language server sh executable to more concise name: $NAME"
        ln -s $ELIXIRLS_RELEASE/language_server.sh $ELIXIRLS_RELEASE/$NAME

        print_colored "$GREEN" "Running initial invocation of $NAME, press <ENTER> when done"
        $ELIXIRLS_RELEASE/./$NAME
    else
        print_colored "$YELLOW" "$NAME sh script already exists, no need to re-install"
    fi
}

# Install Elixir language server since Helix (and apparently Neovim now can) doesn't seem to be able to do so automatically
install_elixirls

# Not stowing at this time, just installing
