#!/bin/sh

echo "🦫 Installing Golang..."

GO_VERSION="1.22.2"

curl -OL https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
rm go${GO_VERSION}.linux-amd64.tar.gz

echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.zshrc

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                  Golang ${GO_VERSION} installed!                 ║"
echo "║ Run 'source ~/.zshrc' or 'source ~/.bashrc' to update your path. ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""