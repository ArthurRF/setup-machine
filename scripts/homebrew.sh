#!/bin/sh

if command -v brew >/dev/null 2>&1; then
  echo "✅ Homebrew is already installed."
  exit 0
fi

echo "🍺 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add brew to PATH for Apple Silicon (/opt/homebrew) and Intel (/usr/local)
if [ -f "/opt/homebrew/bin/brew" ]; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
  echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo ""
echo "╔════════════════════════════╗"
echo "║ ✅ Homebrew installed!     ║"
echo "╚════════════════════════════╝"
echo ""
