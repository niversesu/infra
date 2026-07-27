{inputs, ...}: {
  flake.homeModules.spicetify = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.spicetify-nix.homeManagerModules.default
    ];
    options.myHome.spicetify.enable = lib.mkEnableOption "spicetify";
    config = lib.mkIf config.myHome.spicetify.enable {
      programs.spicetify = {
        enable = true;
        enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions; [
          adblock
          hidePodcasts
          shuffle
          simpleBeautifulLyrics
          bestMoment
        ];
        theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.comfy;
      };
    };
  };
}
