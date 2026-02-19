{
  config,
  pkgs,
  lib,
  nixvim,
  import-tree,
  ...
}: {
  imports = [
    nixvim.homeModules.nixvim
    (import-tree ./modules)
  ];

  # User Configuration
  home = {
    username = "niver";
    homeDirectory = "/home/niver";
    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnfree = true;

  # XDG / MIME Configuration
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/http" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/https" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/about" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/unknown" = ["com.google.Chrome.desktop"];
    };
  };

  xdg.configFile."mimeapps.list".force = true;

  # Input Method Configuration
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
  };
}
