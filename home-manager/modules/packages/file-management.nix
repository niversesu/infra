{ self, ... }: {
  flake.homeModules.pkg-filemanagement = {
    description = "File management tools: Ranger, PCManFM";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ ranger pcmanfm ];
    }) ];
  };
}
