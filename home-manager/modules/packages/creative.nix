{ self, ... }: {
  flake.homeModules.pkg-creative = { pkgs, ... }: {
  home.packages = with pkgs; [
    krita
    gimp3-with-plugins
    kdePackages.kdenlive
  ];
};
}
