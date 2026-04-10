{ self, ... }: {
  flake.homeModules.pkg-gaming = { pkgs, ... }: {
  home.packages = with pkgs; [
    prismlauncher
    packwiz
  ];
};
}
