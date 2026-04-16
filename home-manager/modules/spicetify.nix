{ inputs, ... }: {
  flake.homeModules.spicetify = { pkgs, ... }:
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
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
  };
}
