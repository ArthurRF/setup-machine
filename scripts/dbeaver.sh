#!/bin/sh

echo "🦫 Installing DBeaver..."

if command -v dbeaver >/dev/null 2>&1; then
  echo "✅ DBeaver is already installed."
  exit 0
fi

if [ "$OS_TYPE" = "mac" ]; then
  if [ "$(sysctl -n hw.optional.arm64 2>/dev/null)" = "1" ]; then
    arch -arm64 brew install --cask dbeaver-community
  else
    brew install --cask dbeaver-community
  fi
else
  DBEAVER_VERSION=$(curl -s https://api.github.com/repos/dbeaver/dbeaver/releases/latest | grep '"tag_name"' | sed 's/.*"\([^"]*\)".*/\1/')
  if [ -z "$DBEAVER_VERSION" ]; then
    echo "⚠️  Could not fetch DBeaver version. Install manually from https://dbeaver.io"
    exit 1
  fi
  echo "📦 Installing DBeaver ${DBEAVER_VERSION}..."
  curl -LO "https://github.com/dbeaver/dbeaver/releases/latest/download/dbeaver-ce_${DBEAVER_VERSION}_amd64.deb"
  sudo dpkg -i "dbeaver-ce_${DBEAVER_VERSION}_amd64.deb"
  rm "dbeaver-ce_${DBEAVER_VERSION}_amd64.deb"
fi

echo ""
echo "╔═══════════════════════════╗"
echo "║ ✅ DBeaver installed!     ║"
echo "╚═══════════════════════════╝"
echo ""
