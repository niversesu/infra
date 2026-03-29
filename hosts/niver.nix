{ config, pkgs, lib, ... }:
{
  imports = [
    ../nixos/configuration.nix
    ../variety/gnome.nix
  ];
  networking.hostName = "niver";
}
