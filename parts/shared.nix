{
  self,
  ...
}: {
  flake.nixosModules.shared = {
    config,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.host-kale-hw
      self.nixosModules.host-nomi-hw
      self.nixosModules.host-dream-hw

      self.nixosModules.core-boot
      self.nixosModules.core-kernel
      self.nixosModules.core-nix
      self.nixosModules.core-locale
      self.nixosModules.core-network
      self.nixosModules.core-hardware
      self.nixosModules.core-shell

      self.nixosModules.packages
      self.nixosModules.services

      self.nixosModules.gnome
      self.nixosModules.plasma
      self.nixosModules.illogical
      self.nixosModules.caelestia

      self.nixosModules.keyd

      self.nixosModules.podman
      self.nixosModules.libvirt
      self.nixosModules.ydotool
      self.nixosModules.waydroid
      self.nixosModules.nix-flatpak
      self.nixosModules.obs-studio
    ];

    options.mySystem = {
      shared = {
        enable = lib.mkEnableOption "shared baseline";
        stateVersion = lib.mkOption {
          type = lib.types.str;
          default = "26.05";
        };
        host = lib.mkOption {
          type = lib.types.str;
          default = "kale";
        };
        user = lib.mkOption {
          type = lib.types.str;
          default = "kale";
        };
      };
      profiles = {
        desktop.enable = lib.mkEnableOption "Desktop profile (Gnome + standard GUI tools)";
        virtualization.enable = lib.mkEnableOption "Virtualization profile (Containers, VMs, Android)";
      };
    };

    config = lib.mkIf config.mySystem.shared.enable (lib.mkMerge [
      # Baseline - Essential system services
      {
        mySystem.core.boot.enable = lib.mkDefault true;
        mySystem.core.kernel.enable = lib.mkDefault true;
        mySystem.core.nix.enable = lib.mkDefault true;
        mySystem.core.locale.enable = lib.mkDefault true;
        mySystem.core.network.enable = lib.mkDefault true;
        mySystem.core.hardware.enable = lib.mkDefault true;
        mySystem.core.shell.enable = lib.mkDefault true;

        mySystem.packages.enable = lib.mkDefault true;
        mySystem.services.enable = lib.mkDefault true;
        mySystem.keyd.enable = lib.mkDefault true;

        networking.hostName = lib.mkDefault config.mySystem.shared.host;
        users.users.${config.mySystem.shared.user} = {
          isNormalUser = true;
          extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
        };
        services.getty.autologinUser = lib.mkDefault config.mySystem.shared.user;
      }

      # Desktop Profile
      (lib.mkIf config.mySystem.profiles.desktop.enable {
        mySystem.gnome.enable = lib.mkDefault true;
        mySystem.nix-flatpak.enable = lib.mkDefault true;
        mySystem.obs-studio.enable = lib.mkDefault true;
      })

      # Virtualization Profile
      (lib.mkIf config.mySystem.profiles.virtualization.enable {
        mySystem.waydroid.enable = lib.mkDefault true;
        mySystem.podman.enable = lib.mkDefault true;
        mySystem.libvirt.enable = lib.mkDefault true;
        mySystem.ydotool.enable = lib.mkDefault true;
      })
    ]);
  };

  flake.homeModules.shared = {
    config,
    lib,
    osConfig,
    ...
  }: {
    imports = [
      self.homeModules.nixvim
      self.homeModules.fish
      self.homeModules.theming
      self.homeModules.starship
      self.homeModules.git
      self.homeModules.vscode
      self.homeModules.illogical
      self.homeModules.caelestia
      self.homeModules.qol
      self.homeModules.spicetify
      self.homeModules.packages
      self.homeModules.wallpapers
    ];

    options.myHome.profiles = {
      full.enable = lib.mkEnableOption "Full home profile (Includes all major tool configs)";
      creative.enable = lib.mkEnableOption "Creative profile (Art & Video tools)";
    };

    config = lib.mkIf osConfig.mySystem.shared.enable (lib.mkMerge [
      # Baseline Home (Shell and Git)
      {
        myHome.fish.enable = lib.mkDefault true;
        myHome.theming.enable = lib.mkDefault true;
        myHome.git.enable = lib.mkDefault true;
        myHome.nixvim.enable = lib.mkDefault true;
        myHome.packages.enable = lib.mkDefault true;
        myHome.qol.enable = lib.mkDefault true;

        home.sessionVariables = {
          FLAKE = "${config.home.homeDirectory}/infra";
          NH_FLAKE = "${config.home.homeDirectory}/infra";
        };

        home = {
          username = lib.mkDefault osConfig.mySystem.shared.user;
          homeDirectory = lib.mkDefault "/home/${osConfig.mySystem.shared.user}";
          stateVersion = lib.mkDefault osConfig.mySystem.shared.stateVersion;
        };

        # Auto-sync varieties
        programs.caelestia.enable = lib.mkDefault (osConfig.mySystem.caelestia.enable or false);
        programs.illogical-impulse.enable = lib.mkDefault (osConfig.mySystem.illogical.enable or false);
      }

      # Full Profile
      (lib.mkIf config.myHome.profiles.full.enable {
        myHome.spicetify.enable = lib.mkDefault true;
        myHome.starship.enable = lib.mkDefault true;
        myHome.wallpapers.enable = lib.mkDefault true;
        myHome.vscode.enable = lib.mkDefault true;
      })

      # Creative Profile
      (lib.mkIf config.myHome.profiles.creative.enable {
        myHome.packages.creative.enable = lib.mkDefault true;
      })
    ]);
  };
}
