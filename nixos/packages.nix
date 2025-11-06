{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keyd
    pavucontrol
    lsd
    fcp
    alejandra
    wget
    curl
    unzip
    nautilus
    qpwgraph
    home-manager
    wl-clipboard
    ydotool
    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
    gnome-extensions-cli
    gnomeExtensions.pano
    chromium  # Added for Chrome Remote Desktop
    distrobox
  ];
}

