#!/bin/sh

echo "🐶 Installing Bruno..."

if command -v bruno >/dev/null 2>&1; then
  echo "✅ Bruno is already installed."
  exit 0
fi

if [ "$OS_TYPE" = "mac" ]; then
  brew install --cask bruno
else
  BRUNO_VERSION=$(curl -s https://api.github.com/repos/usebruno/bruno/releases/latest | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
  if [ -z "$BRUNO_VERSION" ]; then
    echo "⚠️  Could not fetch Bruno version. Install manually from https://www.usebruno.com"
    exit 1
  fi
  echo "📦 Installing Bruno ${BRUNO_VERSION}..."
  curl -LO "https://github.com/usebruno/bruno/releases/latest/download/bruno_${BRUNO_VERSION}_amd64_linux.deb"
  sudo dpkg -i "bruno_${BRUNO_VERSION}_amd64_linux.deb"
  rm "bruno_${BRUNO_VERSION}_amd64_linux.deb"
fi

echo ""
echo "╔══════════════════════╗"
echo "║ ✅ Bruno installed!  ║"
echo "╚══════════════════════╝"
echo ""
