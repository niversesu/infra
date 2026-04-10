{ self, ... }: {
  flake.homeModules.pkg-gaming = {
    description = "Gaming related packages: Steam, Lutris";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ steam lutris ];
    }) ];
  };
}
