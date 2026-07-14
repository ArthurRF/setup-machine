#!/bin/sh

echo "👽 Installing Vim..."

if [ "$OS_TYPE" = "mac" ]; then
  brew install vim
else
  sudo apt-get install -y vim
fi

echo ""
echo "╔════════════════════╗"
echo "║ ✅  Vim installed! ║"
echo "╚════════════════════╝"
echo ""
