#!/bin/sh

echo "🚀 Installing Insomnia..."

curl -1sLf \
  'https://packages.konghq.com/public/insomnia/setup.deb.sh' \
  | sudo -E distro=ubuntu codename=focal bash

sudo apt update
sudo apt install insomnia

echo ""
echo "╔════════════════════════╗"
echo "║ ✅ Insomnia installed! ║"
echo "╚════════════════════════╝"
echo ""