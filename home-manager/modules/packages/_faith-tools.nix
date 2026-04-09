{ pkgs, ... }:
{
  home.packages = with pkgs; [
    remmina
    ntfs3g
  ];
}
