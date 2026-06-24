{inputs, ...}: {
  flake.homeModules.qol = {
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];
    options.myHome.qol.enable = lib.mkEnableOption "CLI Quality of Life tools" // {default = true;};

    config = lib.mkIf config.myHome.qol.enable {
      programs.nix-index-database.comma.enable = true;
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };

      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
        enableNushellIntegration = false;
      };

      programs.nix-index = {
        enable = true;
        enableFishIntegration = true;
      };
    };
  };
}
