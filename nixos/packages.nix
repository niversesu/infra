{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xorg.xhost
    fastfetch
    ripgrep
    ffmpeg
    pavucontrol
    fcp
    alejandra
    unzip
    qpwgraph
    keyd
    httpie
    nmap
    aria2
    eza
    wget
    curl
    home-manager
    wl-clipboard
    ydotool
    gnomeExtensions.appindicator
    gnomeExtensions.pano
    distrobox
    waydroid-helper
  ];
}

