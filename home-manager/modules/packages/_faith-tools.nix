{ self, ... }: {
  flake.homeModules.pkg-faithtools = {
    description = "Development tools for Faith: gh, python";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ gh python3 ];
    }) ];
  };
}
