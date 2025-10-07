#!/usr/bin/env bash
set -e

echo "=== Setup Simplified ==="

# Ensure ~/infra exists
if [ ! -d "$HOME/infra" ]; then
    echo "Error: ~/infra directory not found."
    exit 1
fi

# 1️⃣ Move hardware-configuration.nix to ~/infra/nixos
if [ -f /etc/nixos/hardware-configuration.nix ]; then
    echo "Moving /etc/nixos/hardware-configuration.nix to ~/infra/nixos..."
    sudo mv /etc/nixos/hardware-configuration.nix "$HOME/infra/nixos/"
else
    echo "No /etc/nixos/hardware-configuration.nix found, skipping move."
fi

# 2️⃣ Remove /etc/nixos
if [ -d /etc/nixos ]; then
    echo "Removing /etc/nixos..."
    sudo rm -rf /etc/nixos
else
    echo "/etc/nixos already removed or not found."
fi

# 3️⃣ Symlink ~/infra/nixos to /etc/nixos
if [ ! -L /etc/nixos ]; then
    echo "Creating symlink: /etc/nixos → ~/infra/nixos"
    sudo ln -s "$HOME/infra/nixos" /etc/nixos
else
    echo "/etc/nixos is already a symlink, skipping."
fi

# 4️⃣ Symlink home-manager config
HM_TARGET="$HOME/.config/home-manager"
if [ -L "$HM_TARGET" ]; then
    echo "Home-manager symlink already exists at $HM_TARGET."
elif [ -e "$HM_TARGET" ]; then
    echo "Error: $HM_TARGET exists but is not a symlink. Manual check needed."
    exit 1
else
    echo "Creating symlink: ~/.config/home-manager → ~/infra/home-manager"
    mkdir -p "$HOME/.config"
    ln -s "$HOME/infra/home-manager" "$HM_TARGET"
fi

echo "=== Setup Complete ==="

