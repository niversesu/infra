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
    ../modules/_fish-faith.nix
    ../modules/_theming-faith.nix
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
