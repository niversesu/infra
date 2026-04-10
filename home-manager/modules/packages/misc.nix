{ self, ... }: {
  flake.homeModules.pkg-misc = {
    description = "Miscellaneous packages and utility scripts";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ nur.repos.ataraxiasjel.waydroid-script ];
    }) ];
  };
}
