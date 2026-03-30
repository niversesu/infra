{ config, pkgs, lib, ... }:
{
  imports = [
    ./niver-hardware.nix
    ../nixos/configuration.nix
    ../variety/gnome.nix
    ../nixos/modules/keyd.nix
  ];
  networking.hostName = "niver";
    users.users.niver = {
    isNormalUser = true;
    description = "niver";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
  };
}
