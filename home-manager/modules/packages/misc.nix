{ self, ... }: {
  flake.homeModules.pkg-misc = { pkgs, ... }: {
  home.packages = with pkgs; [
    pkgs.nur.repos.ataraxiasjel.waydroid-script
  ];
};
}
