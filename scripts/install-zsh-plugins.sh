#!/bin/sh

echo "🔧 Installing zsh plugins (autosuggestions & syntax highlighting)..."

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Clone zsh-autosuggestions if not already installed
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  echo "✅ zsh-autosuggestions installed."
else
  echo "⚠️  zsh-autosuggestions already installed."
fi

# Clone zsh-syntax-highlighting if not already installed
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  echo "✅ zsh-syntax-highlighting installed."
else
  echo "⚠️  zsh-syntax-highlighting already installed."
fi

if ! grep -q "zsh-autosuggestions" ~/.zshrc; then
  sed -i.bak '/^plugins=/ s/)/ zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
  echo "🔧 Updated plugins in .zshrc."
fi

if ! grep -q "zsh-syntax-highlighting.zsh" ~/.zshrc; then
  echo "
# Syntax highlighting must be sourced at the end
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
  echo "🔧 Appended syntax highlighting source to .zshrc."
fi

echo "🎉 Zsh plugin setup complete! Please restart your terminal or run: `source ~/.zshrc`"
