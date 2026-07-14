#!/bin/sh

echo "📦 Installing/checking Curl..."

if [ "$OS_TYPE" = "mac" ]; then
  if command -v curl >/dev/null 2>&1; then
    echo "✅ Curl is already available on macOS."
  else
    brew install curl
  fi
else
  sudo apt-get install -y curl
fi

echo ""
echo "╔════════════════════╗"
echo "║ ✅ Curl installed! ║"
echo "╚════════════════════╝"
echo ""
