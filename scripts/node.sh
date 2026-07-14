#!/bin/sh

echo "📦 Installing Node.js using NVM..."

echo "🔍 Fetching latest nvm version..."
NVM_VERSION=$(curl -s "https://api.github.com/repos/nvm-sh/nvm/releases/latest" | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
if [ -z "$NVM_VERSION" ]; then
  echo "⚠️  Could not fetch latest nvm version, falling back to 0.40.1"
  NVM_VERSION="0.40.1"
fi

echo "📦 Installing nvm v${NVM_VERSION}..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash

export NVM_DIR="$HOME/.nvm"

if ! grep -q 'nvm.sh' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zshrc"
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.zshrc"
  echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> "$HOME/.zshrc"
fi

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

nvm install --lts

echo ""
echo "╔═══════════════════════╗"
echo "║ ✅ Node.js installed! ║"
echo "╚═══════════════════════╝"
echo ""
