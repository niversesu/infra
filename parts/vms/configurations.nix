{self, ...}: {
  flake.nixosConfigurations = {
    # Kale VM
    kale-vm = self.lib.mkHost {
      module = {...}: {
        imports = [self.nixosModules.shared];
        mySystem.shared = {
          enable = true;
          user = "niver";
          host = "kale";
        };
        mySystem.profiles.desktop.enable = true;
        mySystem.profiles.virtualization.enable = true;
        mySystem.gnome.enable = false;
        mySystem.caelestia.enable = true;
        programs.steam.enable = true;
      };
      user = "niver";
      homeModule = self.homeModules.user-niver;
      extraModules = [self.nixosModules.vm-baseline];
    };

    # Nomi VM
    nomi-vm = self.lib.mkHost {
      module = {...}: {
        imports = [self.nixosModules.shared];
        mySystem.shared = {
          enable = true;
          user = "faith";
          host = "nomi";
        };
        mySystem.profiles.desktop.enable = true;
      };
      user = "faith";
      homeModule = self.homeModules.user-faith;
      extraModules = [self.nixosModules.vm-baseline];
    };

    # Dream VM
    dream-vm = self.lib.mkHost {
      module = {...}: {
        imports = [self.nixosModules.shared];
        mySystem.shared = {
          enable = true;
          user = "amani";
          host = "dream";
        };
        mySystem.profiles.desktop.enable = true;
        mySystem.gnome.enable = false;
        mySystem.plasma.enable = false;
        mySystem.caelestia.enable = true;
        programs.steam.enable = true;
      };
      user = "amani";
      homeModule = self.homeModules.user-amani;
      extraModules = [self.nixosModules.vm-baseline];
    };
  };
}
