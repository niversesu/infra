{ config, pkgs, import-tree, ... }:

{
  imports =
    (import-tree ../nixos)
    ++ (import-tree ../home-manager)
    ++ [ ../variety/gnome.nix ];
}
