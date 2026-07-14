#!/bin/sh

echo "📦 Installing Docker..."

if [ "$OS_TYPE" = "mac" ]; then
  if command -v docker >/dev/null 2>&1; then
    echo "✅ Docker is already installed."
    exit 0
  fi
  brew install --cask docker
  echo "⚠️  Docker Desktop installed. Open Docker.app once to complete the setup."
else
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
  sudo usermod -aG docker $USER
  rm get-docker.sh

  echo "🔧 Installing Docker Compose..."
  sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi

echo ""
echo "╔═══════════════════════════════════════╗"
echo "║ ✅ Docker + Docker Compose installed! ║"
echo "╚═══════════════════════════════════════╝"
echo ""
