#!/bin/sh

echo "🍃 Installing MongoDB Compass..."

if command -v mongodb-compass >/dev/null 2>&1; then
  echo "✅ MongoDB Compass is already installed."
  exit 0
fi

if [ "$OS_TYPE" = "mac" ]; then
  if [ "$(sysctl -n hw.optional.arm64 2>/dev/null)" = "1" ]; then
    arch -arm64 brew install --cask mongodb-compass
  else
    brew install --cask mongodb-compass
  fi
else
  COMPASS_VERSION=$(curl -s https://api.github.com/repos/mongodb-js/compass/releases | grep '"tag_name"' | grep '@mongodb-js/compass@' | head -1 | sed 's/.*@mongodb-js\/compass@\([^"]*\)".*/\1/')
  if [ -z "$COMPASS_VERSION" ]; then
    echo "⚠️  Could not fetch MongoDB Compass version. Install manually from https://www.mongodb.com/try/download/compass"
    exit 1
  fi
  echo "📦 Installing MongoDB Compass ${COMPASS_VERSION}..."
  curl -LO "https://downloads.mongodb.com/compass/mongodb-compass_${COMPASS_VERSION}_amd64.deb"
  sudo dpkg -i "mongodb-compass_${COMPASS_VERSION}_amd64.deb"
  rm "mongodb-compass_${COMPASS_VERSION}_amd64.deb"
fi

echo ""
echo "╔═══════════════════════════════════╗"
echo "║ ✅ MongoDB Compass installed!     ║"
echo "╚═══════════════════════════════════╝"
echo ""
