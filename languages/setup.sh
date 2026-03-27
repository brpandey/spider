#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

# Interactive asdf installer for Erlang and Elixir on Ubuntu
ASDF_DIR="$HOME/.asdf"

ERLANG_VERSION="26.0"
ELIXIR_VERSION="1.15.3-otp-26"


setup_asdf_and_prerequisites() {
    # Install prerequisites only if Erlang or Elixir not installed via asdf
    if ! command -v asdf >/dev/null 2>&1 || \
       ! asdf global erlang >/dev/null 2>&1 && ! asdf global elixir >/dev/null 2>&1; then
        echo "Installing prerequisites..."
        sudo apt update
        sudo apt install -y \
             git curl build-essential autoconf m4 libncurses-dev \
             libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev \
             unixodbc-dev xsltproc fop libxml2-utils libssl-dev
    else
        echo "Prerequisites skipped (Erlang or Elixir already installed)."
    fi

    # Install asdf if missing
    if [ ! -d "$ASDF_DIR" ]; then
        echo "🚀 Cloning asdf..."
        git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch v0.15.0
    fi

    # Source asdf for current session
    . "$ASDF_DIR/asdf.sh"
    . "$ASDF_DIR/completions/asdf.bash"

}

install_erlang_and_elixir() {
    # Add plugins if missing
    if ! asdf plugin list | grep -q "^erlang$"; then
        asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
    fi
    if ! asdf plugin list | grep -q "^elixir$"; then
        asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
    fi

    # Install versions if missing
    if ! asdf list erlang | grep -q "^$ERLANG_VERSION$"; then
        echo "🔍 Installing Erlang $ERLANG_VERSION..."
        asdf install erlang "$ERLANG_VERSION"
    fi
    asdf global erlang "$ERLANG_VERSION"

    if ! asdf list elixir | grep -q "^$ELIXIR_VERSION$"; then
        echo "🔍 Installing Elixir $ELIXIR_VERSION..."
        asdf install elixir "$ELIXIR_VERSION"
    fi
    asdf global elixir "$ELIXIR_VERSION"
}

verify_installation() {
    echo "✅ Verifying installations..."
    echo "Erlang version: $(erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell)"
    echo "Elixir version: $(elixir --version | head -n 1)"
    echo "asdf versions installed:"
    asdf list
}

setup_asdf_and_prerequisites
install_erlang_and_elixir
verify_installation



install_rust() {
    # Check if rustc is already installed
    if command -v rustc >/dev/null 2>&1; then
        echo "✅ Rust is already installed: $(rustc --version)"
        echo "✅ Cargo version: $(cargo --version)"
        return 0
    fi

    echo "✅ Updating package lists..."
    sudo apt update

    echo "✅ Installing prerequisites (build-essential, curl, pkg-config, libssl-dev)..."
    sudo apt install -y build-essential curl pkg-config libssl-dev

    echo "✅ Installing Rust via Rustup..."
    # Non-interactive install: default profile, no prompt
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    print_colored "$GREEN" "✅ Verifying Rust installation..."
    rustc_version=$(rustc --version 2>/dev/null || echo "not installed")
    cargo_version=$(cargo --version 2>/dev/null || echo "not installed")

    print_colored "$YELLOW" "Rust version: $rustc_version"
    print_colored "$YELLOW" "Cargo version: $cargo_version"

}




install_rust

# Not stowing at this time, just installing
