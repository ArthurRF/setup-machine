#!/bin/sh

echo "🚀 Installing Insomnia..."

wget https://github.com/Kong/insomnia/releases/latest/download/Insomnia.Core.deb -O insomnia.deb

sudo dpkg -i insomnia.deb || sudo apt-get install -f -y

rm insomnia.deb

echo ""
echo "╔════════════════════════╗"
echo "║ ✅ Insomnia installed! ║"
echo "╚════════════════════════╝"
echo ""