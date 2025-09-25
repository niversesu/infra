#!/usr/bin/env bash
set -e

echo "=== Setup Status Check ==="

# 1️⃣ Check infra directory move
if [ -d "$HOME/infra" ]; then
    echo "[SKIP] ~/infra already exists."
elif [ -d "../infra" ]; then
    echo "[TODO] Would move ../infra to ~/infra."
else
    echo "[MISSING] ../infra does not exist. Cannot move."
fi

# 2️⃣ Check home-manager symlink
HM_TARGET="$HOME/.config/home-manager"
if [ -L "$HM_TARGET" ]; then
    echo "[SKIP] Home-manager symlink already exists at $HM_TARGET."
elif [ -e "$HM_TARGET" ]; then
    echo "[BLOCKED] $HM_TARGET exists but is not a symlink. Manual check needed."
else
    echo "[TODO] Would create symlink: $HM_TARGET → ~/infra/home-manager"
fi

# 3️⃣ Check NixOS configuration backup and symlink
NIXOS_CONF="/etc/nixos/configuration.nix"
if [ -L "$NIXOS_CONF" ]; then
    echo "[SKIP] /etc/nixos/configuration.nix already a symlink."
elif [ -f "$NIXOS_CONF" ]; then
    if [ -f "$NIXOS_CONF.bak" ]; then
        echo "[SKIP] /etc/nixos/configuration.nix backup already exists."
    else
        echo "[TODO] Would backup /etc/nixos/configuration.nix → /etc/nixos/configuration.nix.bak"
    fi
    echo "[TODO] Would create symlink: /etc/nixos/configuration.nix → ~/infra/nixos/configuration.nix"
else
    echo "[TODO] Would create symlink: /etc/nixos/configuration.nix → ~/infra/nixos/configuration.nix"
fi

echo "=== Status Check Complete ==="

