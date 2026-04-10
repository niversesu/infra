{ self, ... }: {
  flake.homeModules.pkg-browsers = {
    description = "Web browsers: Firefox, Google Chrome";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ firefox google-chrome ];
    }) ];
  };
}
