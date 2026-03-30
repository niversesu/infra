{ config, pkgs, lib, ... }:
{
  imports = [
    ../nixos/configuration.nix
    ../variety/plasma.nix
  ];
  networking.hostName = "faith";
    users.users.faith = {
    isNormalUser = true;
    description = "faith";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "podman"];
  };
}

