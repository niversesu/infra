{...}: {
  flake.homeModules.fish = {
    config,
    lib,
    ...
  }: {
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
          snrs = "sudo nixos-rebuild switch --flake ~/infra#${config.myHome.fish.flakeTarget}";
          cachix-push = "cachix push niversesu $(nix path-info .#nixosConfigurations.#${config.myHome.fish.flakeTarget}.config.system.build.toplevel)";
        };
        interactiveShellInit = ''
          fish_config theme choose ${config.myHome.fish.theme}
        '';
      };
    };
  };
}
