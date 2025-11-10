{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keyd
    httpie
    eza
    fastfetch
    ripgrep
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
    distrobox
    gnome-boxes
  ];
}

