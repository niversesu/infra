{ config, pkgs, lib, ... }:
{
  imports = [
    ../nixos/configuration.nix
    ../variety/gnome.nix
    ../nixos/modules/keyd.nix
  ];
  networking.hostName = "niver";
}
