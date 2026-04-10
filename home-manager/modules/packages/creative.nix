{ self, ... }: {
  flake.homeModules.pkg-creative = {
    description = "Creative tools: GIMP, Inkscape, OBS Studio";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ gimp inkscape obs-studio ];
    }) ];
  };
}
