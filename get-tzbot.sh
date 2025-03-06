#!/bin/bash

# Use ':-' to ensure the default is used if BOT_SCRIPT_LOCATION is unset or empty.
BOT_SCRIPT_LOCATION=${BOT_SCRIPT_LOCATION:-"https://raw.githubusercontent.com/mattTrustzone/tz-bot/master/tz-bot.sh"}

# Check if certbot is installed; if not, install certbot along with the Apache and Nginx plugins.
if ! command -v certbot >/dev/null 2>&1; then
    echo "certbot is not installed. Attempting to install certbot and its plugins..."

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        distro=$ID
    else
        echo "Cannot determine OS distribution. Please install certbot manually."
        exit 1
    fi

    case "$distro" in
        ubuntu|debian)
            sudo apt-get update && \
            sudo apt-get install -y certbot python3-certbot-nginx python3-certbot-apache
            ;;
        fedora)
            sudo dnf install -y certbot certbot-nginx certbot-apache
            ;;
        centos|rhel)
            sudo yum install -y epel-release && \
            sudo yum install -y certbot certbot-nginx certbot-apache
            ;;
        arch)
            sudo pacman -Sy --noconfirm certbot certbot-nginx certbot-apache
            ;;
        opensuse*|suse)
            sudo zypper install -y certbot python3-certbot-nginx python3-certbot-apache
            ;;
        *)
            echo "Unsupported Linux distribution ($distro). Please install certbot and its plugins manually."
            exit 1
            ;;
    esac

    # Re-check if certbot is now installed.
    if ! command -v certbot >/dev/null 2>&1; then
        echo "certbot installation failed. Please install certbot manually."
        exit 1
    fi
fi

function install_tzbot() {
    if ! curl -sf "$BOT_SCRIPT_LOCATION" -o /tmp/tz-bot; then
        echo "Error: Unable to download file from $BOT_SCRIPT_LOCATION"
        exit 1
    fi

    sudo mkdir -p /usr/local/bin
    sudo mv /tmp/tz-bot /usr/local/bin/tz-bot
    sudo chmod +x /usr/local/bin/tz-bot
}

install_tzbot
