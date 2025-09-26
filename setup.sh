#!/usr/bin/env bash
set -e

echo "=== Setup ==="

# 1️⃣ Move infra directory to home
if [ ! -d "$HOME/infra" ]; then
    if [ -d "../infra" ]; then
        echo "Moving ../infra to ~/infra..."
        mv ../infra ~/
    else
        echo "Error: ../infra does not exist."
        exit 1
    fi
else
    echo "~/infra already exists, skipping move."
fi

# 2️⃣ Create symlink for home-manager
HM_TARGET="$HOME/.config/home-manager"
if [ -L "$HM_TARGET" ]; then
    echo "Home-manager symlink already exists at $HM_TARGET."
elif [ -e "$HM_TARGET" ]; then
    echo "Error: $HM_TARGET exists but is not a symlink. Manual check needed."
    exit 1
else
    echo "Creating symlink for home-manager..."
    mkdir -p "$HOME/.config"
    ln -s ~/infra/home-manager "$HM_TARGET"
fi

# 3️⃣ Symlink hypr directory safely
HYPR_TARGET="$HOME/.config/hypr"
if [ -L "$HYPR_TARGET" ]; then
    echo "~/.config/hypr is already a symlink, skipping."
elif [ -e "$HYPR_TARGET" ]; then
    echo "Backing up existing ~/.config/hypr to ~/.config/hypr-bk..."
    mv "$HYPR_TARGET" "${HYPR_TARGET}-bk"
fi

if [ ! -L "$HYPR_TARGET" ]; then
    echo "Creating symlink for hypr..."
    ln -s "$(pwd)/hypr" "$HYPR_TARGET"
fi

# 4️⃣ Backup and symlink NixOS configuration
NIXOS_CONF="/etc/nixos/configuration.nix"
if [ -L "$NIXOS_CONF" ]; then
    echo "/etc/nixos/configuration.nix is already a symlink, skipping."
elif [ -f "$NIXOS_CONF" ]; then
    echo "Backing up existing NixOS config..."
    sudo mv "$NIXOS_CONF" "$NIXOS_CONF.bak"
fi

if [ ! -L "$NIXOS_CONF" ]; then
    echo "Linking new NixOS configuration..."
    sudo ln -s ~/infra/nixos/configuration.nix "$NIXOS_CONF"
fi

echo "=== Setup Complete ==="

