{ self, ... }: {
  flake.homeModules.pkg-fonts = { pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    meslo-lgs-nf
    minecraftia
    montserrat
  ];
};
}
