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
    (import ../modules/_fish.nix { flakeTarget = "kale"; theme = "catppuccin-mocha"; })
    (import ../modules/_theming.nix {cursorName = "Bibata-Modern-Ice"; })
    ../modules/packages/_niver-tools.nix
    #../modules/_illogical.nix
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
