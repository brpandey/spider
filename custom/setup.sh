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

install_docker() {
    local cmd="docker"
    local group_name="docker"
    local additional1="apt-transport-https ca-certificates curl software-properties-common"
    local additional2="docker-ce docker-ce-cli containerd.io"
    local key_url="https://download.docker.com/linux/ubuntu/gpg"
    local key_url2="https://download.docker.com/linux/ubuntu"
    local key_path="/usr/share/keyrings/docker-archive-keyring.gpg"

    local sources_path="/etc/apt/sources.list.d/docker.list"

    if ! command_exists $cmd; then
        # install additional1 if docker cmd is not present
        check_cmd_install_additional "$cmd" "$additional1"

        print_colored "$GREEN" "Adding docker gpg key\n"

        # add docker gpg key
        if ! curl -fsSL $key_url | sudo gpg --dearmor -o $key_path; then
            print_colored "$RED" "Something went wrong during curl of $key_url install or gpg dearmor!"
            exit 1
        fi

        # add docker repo
        echo "deb [arch=$(dpkg --print-architecture) signed-by="$key_path"] "$key_url2" $(lsb_release -cs) stable" | sudo tee "$sources_path" >/dev/null

        print_colored "$GREEN" "Adding docker repo\n"

        # install additional2 if docker cmd is not present
        check_cmd_install_additional "$cmd" "$additional2"

        # Manage docker as non-root user
        # Create docker group
        # https://docs.docker.com/engine/install/linux-postinstall/
        print_colored "$GREEN" "Adding group docker and adding current user to docker group, so docker can be managed as non-root user\n"
        print_colored "$GREEN" "Press <Enter> if group already exists"

        $SUDO_CMD groupadd "$group_name"
        $SUDO_CMD usermod -aG "$group_name" $(whoami)
        newgrp "$group_name" # Activate the changes to the group (rather than having to log back in)

        print_colored "$GREEN" "Turning off docker autostart on boot up"

        # Turn off autostart on boot (for Debian and Ubuntu)
        $SUDO_CMD systemctl disable docker.service
        $SUDO_CMD systemctl disable docker.socket
        $SUDO_CMD systemctl disable containerd.service

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

    if ! command_exists $cmd; then
        if ! wget -qO - $key_url | gpg --dearmor | sudo tee $key_path >/dev/null; then
            print_colored "$RED" "Something went wrong during wget of "$key_url" install or gpg dearmor!"
            exit 1
        fi
        # sudo sh -c 'echo "deb [arch=amd64 signed-by="$key_path"] "$key_url2" any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

        install_package $cmd
    else
        print_colored "$YELLOW" "Package $cmd already exists, no need to install"
    fi
}

install_docker

# Install Elixir language server since Helix (and apparently Neovim now can) doesn't seem to be able to do so automatically
install_elixirls

# Install Rust-based uv
install_fast_python_manager

install_github_desktop

# Not stowing at this time, just installing
