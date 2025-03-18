#!/bin/bash

# Pull in shared top-level functions and variables
source "$(dirname "$0")/../shared.sh"
greeting $0

install_docker() {
    local cmd="docker"
    local group_name="docker"
    local additional1="apt-transport-https ca-certificates curl software-properties-common dnsmasq"
    local additional2="docker-ce docker-ce-cli containerd.io"
    local key_url="https://download.docker.com/linux/ubuntu/gpg"
    local key_url2=$(dirname "$key_url")
    local key_path="/usr/share/keyrings/docker-archive-keyring.gpg"

    local sources_path="/etc/apt/sources.list.d/docker.list"
    local dnsmasq_config="/etc/dnsmasq.d"
    local docker_dns_fix_file="docker-dns-fix.conf"

    if ! command_exists $cmd; then
        # install additional1 if docker cmd is not present
        check_cmd_install_additional "$cmd" "$additional1"
        # docker delete: sudo apt-get purge docker-ce docker-ce-cli containerd.io

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
    fi

    if $SUDO_CMD groupadd "$group_name" >/dev/null 2>&1; then
        # Manage docker as non-root user
        # Create docker group
        # https://docs.docker.com/engine/install/linux-postinstall/
        print_colored "$GREEN" "Adding group docker and adding current user to docker group, so docker can be managed as non-root user\n"
        print_colored "$GREEN" "Press <Enter> if group already exists"

        #        $SUDO_CMD groupadd "$group_name"
        $SUDO_CMD usermod -aG "$group_name" $(whoami)
        newgrp "$group_name" # Activate the changes to the group (rather than having to log back in)
    fi

    if ! command_exists $cmd; then
        print_colored "$GREEN" "Turning off docker autostart on boot up"

        # Turn off autostart on boot (for Debian and Ubuntu)
        $SUDO_CMD systemctl disable docker.service
        $SUDO_CMD systemctl disable docker.socket
        $SUDO_CMD systemctl disable containerd.service

        local output=$($cmd "--version")
        echo $output
        print_colored "$CYAN" "$output"

        # Allows containers to resolve DNS from whatever DNS servers the host machine is using.
        # force copy docker-dns-fix.conf to /etc/dnsmasq.d
        # mkdir $dnsmasq_config
        $SUDO_CMD \cp "$(dirname "$0")/$docker_dns_fix_file" "$dnsmasq_config/"
        $SUDO_CMD service dnsmasq restart

        print_colored "$MAGENTA" "To start/stop docker run: dstart/dstop"
    fi

    if command_exists $cmd; then
        print_colored "$YELLOW" "Package $cmd already exists, no need to reinstall"
    fi
}

install_docker
apply_stow $0
