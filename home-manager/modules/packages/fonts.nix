{ self, ... }: {
  flake.homeModules.pkg-fonts = {
    description = "Personal font collection: JetBrains Mono, Nerdfonts";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ jetbrains-mono (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
    }) ];
  };
}
