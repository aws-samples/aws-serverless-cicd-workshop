#!/bin/bash

# Cloud9 Bootstrap Script
#
# 1. Installs homebrew
# 2. Upgrades to latest AWS CLI
# 3. Upgrades AWS SAM CLI
#
# Usually takes about 8 minutes to complete

set -euxo pipefail

ACCOUNT_ID=$(aws sts get-caller-identity --query 'Account' --output text)
CURRENT_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/\(.*\)[a-z]/\1/')
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

export INFOPATH="/home/linuxbrew/.linuxbrew/share/info"

function _logger() {
    echo -e "$(date) ${YELLOW}[*] $@ ${NC}"
}

function upgrade_sam_cli() {
    _logger "[+] Backing up current SAM CLI"
    cp $(which sam) ~/.sam_old_backup

    _logger "[+] Installing latest SAM CLI"
    # pipx install aws-sam-cli
    # cfn-lint currently clashing with SAM CLI deps
    ## installing SAM CLI via brew instead
    brew tap aws/tap
    brew upgrade aws-sam-cli

    _logger "[+] Updating Cloud9 SAM binary"
    # Allows for local invoke within IDE (except debug run)
    ln -sf $(which sam) ~/.c9/bin/sam
}

function upgrade_existing_packages() {
    _logger "[+] Upgrading system packages"
    if [[ $(command -v apt-get) ]]; then
        sudo apt-get upgrade -y
    elif [[ $(command -v yum) ]]; then
        sudo yum update -y
    fi

    _logger "[+] Upgrading Python pip and setuptools"
    python3 -m pip install --upgrade pip setuptools --user

    _logger "[+] Installing latest AWS CLI"
    # _logger "[+] Installing pipx, and latest AWS CLI"
    # python3 -m pip install --user pipx
    # pipx install awscli
    python3 -m pip install --upgrade --user awscli
}

function install_utility_tools() {
    _logger "[+] Installing jq"
    sudo yum install -y jq
}

function install_linuxbrew() {
    _logger "[+] Creating touch symlink"
    sudo ln -sf /bin/touch /usr/bin/touch

    if [[ $(command -v brew) == "" ]]; then
        _logger "[+] Installing homebrew..."
        echo | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        _logger "[+] Adding homebrew in PATH"
        test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
        test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
        echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
    else
        _logger "[+] Homebrew already installed..."
    fi
}

function main() {
    upgrade_existing_packages
# current Cloud9 AMIs contain a recent SAM version, no install/ upgrade required
    install_linuxbrew
    install_utility_tools
    upgrade_sam_cli

    echo -e "${RED} [!!!!!!!!!] Open up a new terminal to reflect changes ${NC}"
    _logger "[+] Restarting Shell to reflect changes"
    exec ${SHELL}
}

main
