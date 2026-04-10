{ self, ... }: {
  flake.homeModules.pkg-faith-tools = { pkgs, ... }: {
  home.packages = with pkgs; [
    remmina
    ntfs3g
  ];
};
}
