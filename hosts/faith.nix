{ config, pkgs, lib, ... }:
{
  imports = [
    ./faith-hardware.nix
    ../nixos/configuration.nix
    ../variety/gnome.nix
  ];
  networking.hostName = "faith";
    users.users.faith = {
    isNormalUser = true;
    description = "faith";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "podman"];
  };
}

