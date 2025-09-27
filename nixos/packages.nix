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
  ];
}

