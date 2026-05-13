{...}: {
  flake.homeModules.starship = {
    config,
    lib,
    inputs,
    ...
  }: {
    options.myHome.starship.enable = lib.mkEnableOption "starship";
    config = lib.mkIf config.myHome.starship.enable {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        enableInteractive = true;
      };
      home.file = {
        ".config/starship.toml" = {
          source = "${inputs.caelestia-dotfiles}/starship.toml";
          force = true;
        };
      };
    };
  };
}
