{ config, pkgs, lib, ... }:
{
  imports = [
    ../nixos/configuration.nix
    ../variety/plasma.nix
  ];
  networking.hostName = "faith";
}

