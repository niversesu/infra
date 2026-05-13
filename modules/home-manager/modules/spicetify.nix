{inputs, ...}: {
  flake.homeModules.spicetify = {
    config,
    lib,
    pkgs,
    ...
  }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
    options.myHome.spicetify.enable = lib.mkEnableOption "spicetify";
    config = lib.mkIf config.myHome.spicetify.enable {
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
  };
}
