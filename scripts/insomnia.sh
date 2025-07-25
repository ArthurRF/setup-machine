#!/bin/sh

set -e

echo "🚀 Installing Insomnia..."

sudo apt-get update
sudo apt-get install -y wget gpg

wget -qO- https://insomnia.rest/keys/debian-public.key.asc | sudo gpg --dearmor -o /usr/share/keyrings/insomnia-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/insomnia-archive-keyring.gpg] https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee /etc/apt/sources.list.d/insomnia.list

sudo apt-get update
sudo apt-get install -y insomnia

echo "✅ Insomnia installation complete!"
