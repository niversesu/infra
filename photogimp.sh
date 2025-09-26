#!/usr/bin/env bash
set -euo pipefail

PHOTO_URL="https://github.com/Diolinux/PhotoGIMP/releases/download/3.0/PhotoGIMP-linux.zip"
TMP_DIR=$(mktemp -d)
DESKTOP_FILE="$HOME/.local/share/applications/org.gimp.GIMP.desktop"

# Check if PhotoGIMP is already installed
if [ -f "$DESKTOP_FILE" ] && grep -iq "photogimp" "$DESKTOP_FILE"; then
    echo "PhotoGIMP is already installed. Aborting."
    exit 0
fi

echo "Downloading PhotoGIMP..."
wget -O "$TMP_DIR/PhotoGIMP.zip" "$PHOTO_URL"

echo "Unzipping..."
unzip -q "$TMP_DIR/PhotoGIMP.zip" -d "$TMP_DIR"

echo "Installing PhotoGIMP..."
cp -r "$TMP_DIR/PhotoGIMP-linux/.config" "$HOME/"
cp -r "$TMP_DIR/PhotoGIMP-linux/.local" "$HOME/"

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "PhotoGIMP installation complete!"

