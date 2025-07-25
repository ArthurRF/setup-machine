#!/bin/sh

echo "🖥️ Installing Visual Studio Code..."

if command -v code >/dev/null 2>&1; then
    echo "VS Code is already installed."
    exit 0
fi

sudo apt update
sudo apt install -y wget gpg

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

rm -f packages.microsoft.gpg

sudo apt update
sudo apt install -y code

echo ""
echo "╔══════════════════════════════════════╗"
echo "║ ✅ VS Code installation completed!   ║"
echo "╚══════════════════════════════════════╝"
echo ""
