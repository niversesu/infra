{ pkgs, ... }:
{
  home.packages = with pkgs; [
    remmina
    ntfs3g
    keyd
    ydotool
    distrobox
    podman-compose
  ];
}
