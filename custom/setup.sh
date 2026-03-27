#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

install_fast_python_manager() {
    local install_url="https://astral.sh/uv/install.sh"
    local cmd="uv"

    if ! command_exists $cmd; then
        if ! curl -LsSf $install_url | sh; then
            print_colored "$RED" "Something went wrong during curl of $cmd install!"
            exit 1
        fi

        local output=$($cmd "--version")
        echo $output
        print_colored "$GREEN" "$output"
    else
        print_colored "$YELLOW" "Package $cmd already exists, no need to reinstall"
    fi
}

install_elixirls() {
    local target_path="$HOME/.local/share"
    local release_path="$target_path/elixir-ls/release"
    local git_repo="git@github.com:elixir-lsp/elixir-ls.git"
    local name="elixir-ls"

    if [ ! -L "$release_path/$name" ]; then
        git -C $target_path clone $git_repo
        cd "$target_path/$name"
        print_colored "$GREEN" "About to run mix deps.get to pull down dependencies"

        mix deps.get
        mkdir $release_path
        print_colored "$GREEN" "Created release directory"

        export MIX_ENV=prod
        print_colored "$GREEN" "Running mix elixir_ls.release2"
        mix elixir_ls.release2 -0 elixir-ls
        env | grep MIX_ENV

        cd $release_path
        ls $release_path

        print_colored "$GREEN" "Symbolic linking language server sh executable to more concise name: $name"
        ln -s $release_path/language_server.sh $release_path/$name

        print_colored "$GREEN" "Running initial invocation of $name, press <ENTER> when done"
        $release_path/./$name
    else
        print_colored "$YELLOW" "$name sh script already exists, no need to re-install"
    fi
}

install_github_desktop() {
    local cmd="github-desktop"
    local key_url="https://apt.packages.shiftkey.dev/gpg.key"
    local key_url2="https://apt.packages.shiftkey.dev/ubuntu/"
    local key_path="/usr/share/keyrings/shiftkey-packages.gpg"
    local sources_path="/etc/apt/sources.list.d/shiftkey-packages.list"

    if ! command_exists $cmd; then
        if ! wget -qO - $key_url | gpg --dearmor | $SUDO_CMD tee $key_path >/dev/null; then
            print_colored "$RED" "Something went wrong during wget of "$key_url" install or gpg dearmor!"
            exit 1
        fi

        echo "deb [arch=$(dpkg --print-architecture) signed-by="$key_path"] "$key_url2" any main" | $SUDO_CMD tee "$sources_path" >/dev/null

        install_package $cmd
    else
        print_colored "$YELLOW" "Package $cmd already exists, no need to install"
    fi
}

# Install Elixir language server since Helix (and apparently Neovim now can) doesn't seem to be able to do so automatically
# install_elixirls

# Install Rust-based uv
install_fast_python_manager

install_github_desktop

# Not stowing at this time, just installing
