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
    if ! command -v asdf >/dev/null 2>&1 ||
        ! asdf current erlang >/dev/null 2>&1 && ! asdf current elixir >/dev/null 2>&1; then
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

setup_asdf_and_prerequisites
install_erlang_and_elixir

#install_phoenix

install_phoenix() {
    if command -v mix >/dev/null 2>&1; then
        echo "Install phoenix"
        mix archive.install hex phx_new
        return 0
    fi
}

install_rust() {
    # Check if rustc is already installed
    if command -v rustc >/dev/null 2>&1; then
        echo "Rust is already installed: $(rustc --version)"
        echo "Cargo version: $(cargo --version)"
        return 0
    fi

    echo "Updating package lists..."
    sudo apt update

    echo "Installing prerequisites (build-essential, curl, pkg-config, libssl-dev)..."
    sudo apt install -y build-essential curl pkg-config libssl-dev

    echo "Installing Rust via Rustup..."
    # Non-interactive install: default profile, no prompt
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    print_colored "$GREEN" "Verifying Rust installation..."
    rustc_version=$(rustc --version 2>/dev/null || echo "not installed")
    cargo_version=$(cargo --version 2>/dev/null || echo "not installed")

    print_colored "$YELLOW" "Rust version: $rustc_version"
    print_colored "$YELLOW" "Cargo version: $cargo_version"

}

install_rust

install_go() {
    set -e

    GO_VERSION="1.26.1"
    ARCH="linux-amd64"
    INSTALL_DIR="/usr/local/go"

    echo "Checking for existing Go installation..."

    if command -v go >/dev/null 2>&1; then
        CURRENT_VERSION=$(go version | awk '{print $3}')
        echo "Found Go: $CURRENT_VERSION"

        if [ "$CURRENT_VERSION" = "go$GO_VERSION" ]; then
            echo "Go $GO_VERSION is already installed. Skipping."
            return 0
        else
            echo "Different version detected. Upgrading to $GO_VERSION..."
        fi
    else
        echo "Go not found. Installing..."
    fi

    cd /tmp
    curl -LO https://go.dev/dl/go${GO_VERSION}.${ARCH}.tar.gz

    sudo rm -rf "$INSTALL_DIR"
    sudo tar -C /usr/local -xzf go${GO_VERSION}.${ARCH}.tar.gz

    export PATH=$PATH:/usr/local/go/bin
    echo "Installed Go version:"
    go version

    echo "Restart shell or run: source ~/.bashrc"
}

install_go

install_haskell() {
    set -e

    echo "Checking for existing Haskell toolchain..."

    if command -v ghcup >/dev/null 2>&1; then
        echo "GHCup already installed."
        source "$HOME/.ghcup/env"
    else
        echo "GHCup not found. Installing..."
        curl https://get-ghcup.haskell.org -sSf | BOOTSTRAP_HASKELL_NONINTERACTIVE=1 sh
        source "$HOME/.ghcup/env"
    fi

    # Check GHC
    if command -v ghc >/dev/null 2>&1; then
        echo "GHC already installed: $(ghc --version)"
    else
        echo "Installing GHC..."
        ghcup install ghc
        ghcup set ghc latest
    fi

    # Check cabal
    if command -v cabal >/dev/null 2>&1; then
        echo "cabal already installed: $(cabal --version | head -n 1)"
    else
        echo "Installing cabal..."
        ghcup install cabal
        ghcup set cabal latest
    fi

    # Check HLS
    if command -v haskell-language-server >/dev/null 2>&1; then
        echo "Haskell Language Server already installed."
    else
        echo "Installing HLS..."
        ghcup install hls
        ghcup set hls latest
    fi

    # Create unversioned symlink for convenience
    if [ ! -f "$HOME/.ghcup/bin/haskell-language-server" ]; then
        ln -s "$HOME/.ghcup/bin/haskell-language-server-wrapper" "$HOME/.ghcup/bin/haskell-language-server"
    fi

    echo "Final versions:"
    ghc --version
    cabal --version
    haskell-language-server --version

    echo "Done. Restart shell or run: source ~/.ghcup/env"
}

install_haskell

# Not stowing at this time, just installing
