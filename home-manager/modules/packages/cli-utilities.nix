{ self, ... }: {
  flake.homeModules.pkg-cli-utilities = { pkgs, ... }: {
  home.packages = with pkgs; [
    gemini-cli-bin
  ];
};
}
