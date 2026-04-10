{ 
  inputs,
  config,
  pkgs,
  lib,
  nixvim,
  import-tree,
  ...
}: {
  imports = [
    nixvim.homeModules.nixvim
    (import-tree ../modules)
    (import ../modules/_fish.nix { flakeTarget = "nomi"; theme = "catppuccin-frappe"; })
    (import ../modules/_theming.nix {cursorName = "Bibata-Modern-Amber"; })
    ../modules/packages/_faith-tools.nix
    #../modules/_illogical.nix
  ];
  # User Configuration
  home = {
    username = "faith";
    homeDirectory = "/home/faith";
    stateVersion = "25.05";
  };
  nixpkgs.config.allowUnfree = true;
}
