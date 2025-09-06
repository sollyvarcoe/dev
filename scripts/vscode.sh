#!/bin/bash

# Exit on error
set -e

# Temporary directory for download
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

echo "🔍 Fetching the latest Visual Studio Code .deb package..."

# Get the latest .deb download URL for VS Code (stable release)
VSCODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

# Output file name
DEB_FILE="vscode-latest.deb"

# Download the .deb package
wget -O "$DEB_FILE" "$VSCODE_URL"

echo "📦 Downloaded VS Code package: $DEB_FILE"

# Install the package
echo "🚀 Installing Visual Studio Code..."
sudo apt update
sudo apt install -y ./"$DEB_FILE"

echo "✅ Visual Studio Code installation complete!"

# Clean up
cd ~
rm -rf "$TMP_DIR"
