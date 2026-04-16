{ self, ... }: {
  flake.homeModules.fish = { config, pkgs, lib, ... }: {
    options.myHome.fish = {
      enable = lib.mkEnableOption "fish";
      flakeTarget = lib.mkOption {
        type = lib.types.str;
        default = "kale";
      };
      theme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-mocha";
      };
    };

    config = lib.mkIf config.myHome.fish.enable {
      programs.fish = {
        enable = true;
        shellAliases = {
          nano = "nvim";
          ls = "eza --all --icons --color=auto --time-style=iso --classify";
          snrs = "sudo nixos-rebuild switch --flake .#${config.myHome.fish.flakeTarget}";
        };
        interactiveShellInit = ''
          fish_config theme choose ${config.myHome.fish.theme}
        '';
      };
    };
  };
}
