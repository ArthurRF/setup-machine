#!/bin/sh

if [ "$OS_TYPE" = "mac" ]; then
  echo "ℹ️  On macOS, Docker Desktop manages permissions automatically."
  echo "    No additional configuration needed."
  exit 0
fi

echo "🚧 Configuring Docker to run without sudo..."

sudo groupadd docker
sudo usermod -aG docker $USER

echo ""
echo "╔═══════════════════════╗"
echo "║ ✅ Docker configured! ║"
echo "╚═══════════════════════╝"
echo ""
