#!/usr/bin/env bash

function main() {
    clear
    echo "👊🏼 This script allocates a swap partition and makes it persistant after reboots."
    read -p "🤔 How much swap do you want in GB? " amount

    sudo fallocate -l ${amount}G /swapfile
    ls -lh /swapfile

    sudo chmod 600 /swapfile
    ls -lh /swapfile

    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo swapon --show

    free -h

    sudo cp /etc/fstab /etc/fstab.bak
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    if [ $? -eq 0 ]; then
        echo "✅ Done."
    else
        echo "❌ An error occured."
    fi
}

main
