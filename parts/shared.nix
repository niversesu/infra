{
  self,
  lib,
  ...
}: {
  flake.nixosModules.shared = {
    config,
    lib,
    inputs,
    ...
  }: {
    imports = [
      self.nixosModules.host-kale-hw
      self.nixosModules.host-nomi-hw
      self.nixosModules.host-dream-hw

      self.nixosModules.configuration
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

    config = lib.mkIf config.mySystem.shared.enable {
      # Baseline - Always on for all hosts
      mySystem.configuration.enable = lib.mkDefault true;
      mySystem.packages.enable = lib.mkDefault true;
      mySystem.services.enable = lib.mkDefault true;
      mySystem.keyd.enable = lib.mkDefault true;

      # Profile: Desktop (Plumbing & Default DE)
      mySystem.gnome.enable = lib.mkDefault config.mySystem.profiles.desktop.enable;
      mySystem.nix-flatpak.enable = lib.mkDefault config.mySystem.profiles.desktop.enable;
      mySystem.obs-studio.enable = lib.mkDefault config.mySystem.profiles.desktop.enable;
      
      # Desktop Alternatives (Explicitly OFF by default, even with Desktop Profile)
      mySystem.plasma.enable = lib.mkDefault false;
      mySystem.caelestia.enable = lib.mkDefault false;
      mySystem.illogical.enable = lib.mkDefault false;

      # Profile: Virtualization (Infrastructure)
      mySystem.waydroid.enable = lib.mkDefault config.mySystem.profiles.virtualization.enable;
      mySystem.podman.enable = lib.mkDefault config.mySystem.profiles.virtualization.enable;
      mySystem.libvirt.enable = lib.mkDefault config.mySystem.profiles.virtualization.enable;
      mySystem.ydotool.enable = lib.mkDefault config.mySystem.profiles.virtualization.enable;

      networking.hostName = "${config.mySystem.shared.host}";
      users.users.${config.mySystem.shared.user} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
      };
      services.getty.autologinUser = config.mySystem.shared.user;
    };
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

    config = lib.mkIf osConfig.mySystem.shared.enable {
      # Baseline Home (Minimal CLI)
      myHome.fish.enable = lib.mkDefault true;
      myHome.theming.enable = lib.mkDefault true;
      myHome.git.enable = lib.mkDefault true;
      myHome.nixvim.enable = lib.mkDefault true;
      myHome.packages.enable = lib.mkDefault true;
      myHome.qol.enable = lib.mkDefault true;

      # Full Profile (The standard desktop experience)
      myHome.spicetify.enable = lib.mkDefault config.myHome.profiles.full.enable;
      myHome.starship.enable = lib.mkDefault config.myHome.profiles.full.enable;
      myHome.wallpapers.enable = lib.mkDefault config.myHome.profiles.full.enable;
      myHome.vscode.enable = lib.mkDefault config.myHome.profiles.full.enable;

      # Tying Home Varieties to System Varieties
      # (Only active if the corresponding system variety is enabled)
      programs.caelestia.enable = lib.mkDefault (osConfig.mySystem.caelestia.enable or false);
      programs.illogical-impulse.enable = lib.mkDefault (osConfig.mySystem.illogical.enable or false);

      # Creative Profile
      myHome.packages.creative.enable = lib.mkDefault config.myHome.profiles.creative.enable;

      home.sessionVariables = {
        FLAKE = "${config.home.homeDirectory}/infra";
        NH_FLAKE = "${config.home.homeDirectory}/infra";
      };

      home = {
        username = osConfig.mySystem.shared.user;
        homeDirectory = "/home/${osConfig.mySystem.shared.user}";
        stateVersion = "26.05";
      };
    };
  };
}
