{ config, pkgs, lib, ... }:
{
  imports = [
    ../nixos/configuration.nix
    ../variety/gnome.nix
    ../nixos/modules/systemd.nix
  ];
  networking.hostName = "niver";
}
