{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.filelight
    rclone
  ];
}
