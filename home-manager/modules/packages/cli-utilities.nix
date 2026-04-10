{ self, ... }: {
  flake.homeModules.pkg-cliutilities = {
    description = "CLI utilities: bat, fzf, jq, etc.";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ bat fzf jq tree ];
    }) ];
  };
}
