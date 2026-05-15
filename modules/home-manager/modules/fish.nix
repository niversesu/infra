{...}: {
  flake.homeModules.fish = {
    config,
    lib,
    osConfig,
    ...
  }: {
    options.myHome.fish = {
      enable = lib.mkEnableOption "fish";
      flakeTarget = lib.mkOption {
        type = lib.types.str;
        default = osConfig.networking.hostName;
      };
      theme = lib.mkOption {
        type = lib.types.str;
        default = "catppuccin-mocha";
      };
    };

    config = lib.mkIf config.myHome.fish.enable (lib.mkMerge [
      {
        xdg.configFile."fish/config.fish".force = true;

        programs.fish = {
          enable = true;
          shellAliases = {
            cp = "cpx";
            ls = "eza --all --icons --color=auto --time-style=iso --classify";
            cat = "bat";
            y = "yazi";
            du = "dust";
            grep = "rg";
            find = "fd";
            neofetch = "fastfetch";
            cd = "z";
            docker = "podman";
            nano = "nvim";
            cachix-push = "cachix push $NH_FLAKE#nixosConfigurations.${config.myHome.fish.flakeTarget}.config.system.build.toplevel";
            nix-gc = "nh clean all --keep 5";
            nix-diff = "nvd diff /nix/var/nix/profiles/system-$(math (readlink /nix/var/nix/profiles/system | string replace -r '.*-([0-9]+)-link' '$1') - 1)-link /nix/var/nix/profiles/system";
            z-prime = "find . -maxdepth 3 -not -path '*/.*' -type d -exec zoxide add {} +";
          };
          shellAbbrs = {
            g = "lazygit";
            ga = "git add .";
            cam = "git commit --amend --no-edit";
            cm = "git commit -m";
            ca = "git commit -am";
            ps = "git push";
            pl = "git pull";
            st = "git status";
          };
          functions = {
            nix = {
              body = ''
                switch $argv[1]
                    case build shell develop
                        nom $argv
                    case '*'
                        command nix $argv
                end
              '';
            };
            snrs = {
              body = ''
                git -C $NH_FLAKE add .
                if test (git -C $NH_FLAKE log -1 --pretty=%s) = "wip"
                    git -C $NH_FLAKE commit --amend --no-edit
                else
                    git -C $NH_FLAKE commit -m "wip"
                end
                nh os switch $NH_FLAKE
              '';
            };
          };
          interactiveShellInit = ''
            fish_config theme choose ${config.myHome.fish.theme} 
          '';
        };
      }

      (lib.mkIf (osConfig.mySystem.caelestia.enable or false) {
        programs.fish.interactiveShellInit = ''
          if type -q caelestia
            caelestia scheme set -n dynamic 
          end
        '';
      })
    ]);
  };
}
