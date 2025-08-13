#!/bin/sh

echo "📦 Installing Node.js using NVM..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | zsh
export NVM_DIR="$HOME/.nvm"

# Add NVM initialization to .zshrc if not already added
if ! grep -q 'nvm.sh' "$HOME/.zshrc"; then
  echo 'export NVM_DIR="$HOME/.nvm"' >> "$HOME/.zshrc"
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> "$HOME/.zshrc"
  echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/bash_completion"' >> "$HOME/.zshrc"
fi

. "$NVM_DIR/nvm.sh"

nvm install --lts

echo ""
echo "╔═══════════════════════╗"
echo "║ ✅ Node.js installed! ║"
echo "╚═══════════════════════╝"
echo ""