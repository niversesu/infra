{ config, pkgs, lib, ... }:
{
  imports = [
    ./nomi-hardware.nix
    ../nixos/configuration.nix
    ../variety/illogical-base.nix
    #../variety/gnome.nix
  ];
  networking.hostName = "faith";
    users.users.faith = {
    isNormalUser = true;
    description = "faith";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "podman"];
  };
}

