#!/bin/sh

echo "🦫 Installing Golang..."

echo "🔍 Fetching latest Go version..."
GO_VERSION=$(curl -s "https://go.dev/dl/?mode=json" | grep -o '"version":"go[^"]*"' | head -1 | sed 's/"version":"go//;s/"//')

if [ -z "$GO_VERSION" ]; then
  echo "⚠️  Could not fetch latest version, falling back to 1.24.5"
  GO_VERSION="1.24.5"
fi

echo "📦 Installing Go ${GO_VERSION}..."

if [ "$OS_TYPE" = "mac" ]; then
  # On macOS, use Homebrew — always installs the latest stable version
  brew install go
else
  FILENAME="go${GO_VERSION}.linux-amd64.tar.gz"
  curl -OL "https://go.dev/dl/${FILENAME}"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "${FILENAME}"
  rm "${FILENAME}"

  if ! grep -q '/usr/local/go/bin' ~/.zshrc 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc
  fi
  if ! grep -q '/usr/local/go/bin' ~/.bashrc 2>/dev/null; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
  fi
fi

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║            Golang ${GO_VERSION} installed!                        ║"
echo "║ Run 'source ~/.zshrc' or 'source ~/.bashrc' to update your path. ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
