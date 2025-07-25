#!/bin/sh

set -e

echo "📦 Installing Docker..."

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

echo "👤 Adding current user to docker group..."
sudo usermod -aG docker "$USER"

if command -v newgrp >/dev/null 2>&1; then
  echo "🔄 Reloading group membership..."
  exec newgrp docker << END
echo "✅ You can now use Docker without sudo!"
END
else
  echo "⚠️ Please log out and back in or restart your terminal to use Docker without sudo."
fi

echo "🔧 Installing Docker Compose..."

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo
echo "✅ Docker + Docker Compose installed!"
