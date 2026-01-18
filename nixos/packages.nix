{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keyd
    httpie
    nmap
    eza
    xorg.xhost
    fastfetch
    ripgrep
    ffmpeg
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
    gnomeExtensions."all-in-one-clipboard"
    distrobox
    waydroid-helper
    gnome-boxes
    aria2
    xxd
  ];
}

