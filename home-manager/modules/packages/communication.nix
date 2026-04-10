{ self, ... }: {
  flake.homeModules.pkg-communication = { pkgs, ... }: {
  home.packages = with pkgs; [
    vesktop
  ];
};
}
