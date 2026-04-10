{ self, ... }: {
  flake.homeModules.pkg-browsers = { pkgs, ... }: {
  home.packages = with pkgs; [
    firefox
    google-chrome
  ];
};
}
