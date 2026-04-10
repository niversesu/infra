{ config, pkgs, lib, ... }:
{
  imports = [
    ./kale-hardware.nix
    ../nixos/configuration.nix
    #../variety/illogical-base.nix
    ../variety/gnome.nix
    ../nixos/modules/keyd.nix
    ../nixos/modules/virt-ydot.nix
  ];
  networking.hostName = "niver";
    users.users.niver = {
    isNormalUser = true;
    description = "niver";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
  };
  services.getty.autologinUser = "niver";
}
