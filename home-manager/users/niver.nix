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
    ../modules/_fish-niver.nix
    ../modules/packages/_niver-tools.nix
    ../modules/_theming-niver.nix
  ];
  # User Configuration
  home = {
    username = "niver";
    homeDirectory = "/home/niver";
    stateVersion = "25.05";
  };
  nixpkgs.config.allowUnfree = true;
  # Input Method Configuration
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
  };
}
