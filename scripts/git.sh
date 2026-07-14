#!/bin/sh

echo "🔧 Checking if Git is installed..."

if ! command -v git >/dev/null 2>&1; then
  echo "🚧 Git not found. Installing Git..."
  if [ "$OS_TYPE" = "mac" ]; then
    brew install git
  else
    sudo apt update
    sudo apt install -y git
  fi
else
  echo "✅ Git is already installed."
fi

echo "🛠️  Configuring Git..."

git config --global user.name "Arthur Roberto Fronza"
git config --global user.email "arthur_fronza2011@hotmail.com"
git config --global init.defaultBranch master
git config --global pull.rebase false

# Aliases
git config --global alias.aa "add ."
git config --global alias.cm "commit -m"
git config --global alias.cc "checkout -b"
git config --global alias.ch "checkout"
git config --global alias.sl "stash list"
git config --global alias.sp "stash pop"
git config --global alias.s "stash"

echo ""
echo "╔════════════════════╗"
echo "║ ✅ Git configured! ║"
echo "╚════════════════════╝"
echo ""
