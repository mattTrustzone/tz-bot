#!/bin/bash

BOT_SCRIPT_LOCATION=${BOT_SCRIPT_LOCATION-"https://raw.githubusercontent.com/tz/tz-bot/master/tz-bot.sh"}

function install_tzbot()
{
    curl -s "$BOT_SCRIPT_LOCATION" > /tmp/tz-bot
    sudo bash <<EOF
        mkdir -p /usr/local/bin && \
        mv /tmp/tz-bot /usr/local/bin/tz-bot && \
        chmod +x /usr/local/bin/tz-bot
EOF
}

install_tzbot
