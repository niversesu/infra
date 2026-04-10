{ self, ... }: {
  flake.homeModules.pkg-file-management = { pkgs, ... }: {
  home.packages = with pkgs; [
    kdePackages.filelight
    rclone
  ];
};
}
