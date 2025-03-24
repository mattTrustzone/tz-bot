#!/bin/bash

# Use ':-' to ensure the default is used if BOT_SCRIPT_LOCATION is unset or empty.
BOT_SCRIPT_LOCATION=${BOT_SCRIPT_LOCATION:-"https://raw.githubusercontent.com/mattTrustzone/tz-bot/master/tz-bot.sh"}

# Check if certbot is installed; if not, install certbot using Snap.
if ! command -v certbot >/dev/null 2>&1; then
    echo "certbot is not installed. Attempting to install certbot using Snap..."
    sudo snap install --classic certbot
    sudo ln -s /snap/bin/certbot /usr/bin/certbot

    # Re-check if certbot is now installed.
    if ! command -v certbot >/dev/null 2>&1; then
        echo "certbot installation failed. Please install certbot manually."
        exit 1
    fi
fi

# Check if Apache is installed and install the Certbot Apache plugin if necessary.
if command -v apache2 >/dev/null 2>&1; then
    echo "Apache is installed. Installing Certbot Apache plugin..."
    sudo apt-get update
    sudo apt-get install -y python3-certbot-apache
fi

# Check if Nginx is installed and install the Certbot Nginx plugin if necessary.
if command -v nginx >/dev/null 2>&1; then
    echo "Nginx is installed. Installing Certbot Nginx plugin..."
    sudo apt-get update
    sudo apt-get install -y python3-certbot-nginx
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
