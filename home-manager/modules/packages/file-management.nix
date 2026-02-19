{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.filelight
    motrix
    rclone
  ];
}
