{ spicetify-nix, pkgs, ... }: let
  system = pkgs.stdenv.hostPlatform.system;
  spicePkgs = spicetify-nix.legacyPackages.${system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      simpleBeautifulLyrics
      bestMoment
    ];
    theme = spicePkgs.themes.comfy;
  };
}
