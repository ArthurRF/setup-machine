#!/bin/sh

echo "🚧 Configuring Docker to run without sudo..."

sudo groupadd docker
sudo usermod -aG docker $USER

echo "✅ Docker configured!\n"
