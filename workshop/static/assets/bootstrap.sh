#!/bin/bash

# Cloud9 Bootstrap Script
#
# Testing on Amazon Linux 2
#
# 1. Installs homebrew
# 2. Upgrades to latest AWS CLI
# 3. Upgrades AWS SAM CLI
#
# Usually takes about 8 minutes to complete

set -euxo pipefail

RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SAM_INSTALL_DIR="sam-installation"

function _logger() {
    echo -e "$(date) ${YELLOW}[*] $@ ${NC}"
}

function update_system() {
    _logger "[+] Updating system packages"
    sudo yum update -y --skip-broken
}

function update_python_packages() {
    _logger "[+] Upgrading Python pip and setuptools"
    python3 -m pip install --upgrade pip setuptools --user

    _logger "[+] Installing latest AWS CLI"
    # --user installs into $HOME/.local/bin/aws. After this is installed, remove the prior version
    # in /usr/bin/. The --upgrade isn't necssary on a new install, but saft to leave in if Cloud9
    # ever installs the aws-cli this way.
    python3 -m pip install --upgrade --user awscli
    if [[ -f /usr/bin/aws ]]; then
        sudo rm -rf /usr/bin/aws*
    fi
}

function install_utility_tools() {
    _logger "[+] Installing jq"
    sudo yum install -y jq
}

function upgrade_sam_cli() {
    if [[ ! -f aws-sam-cli-linux-x86_64.zip ]]; then
        _logger "[+] Dowloading latest SAM version"
        curl -Ls -O https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
    fi

    if [[ ! -d $SAM_INSTALL_DIR ]]; then
        unzip aws-sam-cli-linux-x86_64.zip -d $SAM_INSTALL_DIR
    fi

    _logger "[+] Updating SAM..."
    sudo ./$SAM_INSTALL_DIR/install --update

    _logger "[+] Updating Cloud9 SAM binary"
    # Allows for local invoke within IDE (except debug run)
    ln -sf $(which sam) ~/.c9/bin/sam
}

function cleanup() {
    if [[ -d $SAM_INSTALL_DIR ]]; then
        rm -rf $SAM_INSTALL_DIR
    fi
}

function main() {
    update_system
    update_python_packages
    install_utility_tools
    upgrade_sam_cli
    cleanup

    echo -e "${RED} [!!!!!!!!!] To be safe, I suggest closing this terminal and opening a new one! ${NC}"
    _logger "[+] Restarting Shell to reflect changes"
    exec ${SHELL}
}

main
