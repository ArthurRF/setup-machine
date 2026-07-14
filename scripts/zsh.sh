#!/bin/sh

echo "💻 Installing ZSH and Powerlevel10k..."

if [ "$OS_TYPE" = "mac" ]; then
  if ! command -v zsh >/dev/null 2>&1; then
    brew install zsh
  else
    echo "✅ ZSH is already available on macOS."
  fi
else
  sudo apt install -y zsh git curl
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k

# sed -i.bak is portable: works on both GNU (Linux) and BSD (macOS)
sed -i.bak 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
rm -f ~/.zshrc.bak

echo ""
echo "╔════════════════════╗"
echo "║ ✅ ZSH configured! ║"
echo "╚════════════════════╝"
echo ""
