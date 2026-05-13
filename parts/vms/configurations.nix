{self, ...}: {
  flake.nixosConfigurations = {
    # Kale VM
    kale-vm = self.lib.mkHost {
      module = self.nixosModules.host-kale;
      user = "niver";
      homeModule = self.homeModules.user-niver;
      extraModules = [
        self.nixosModules.vm-baseline
        ({...}: { })
      ];
    };

    # Nomi VM
    nomi-vm = self.lib.mkHost {
      module = self.nixosModules.host-nomi;
      user = "faith";
      homeModule = self.homeModules.user-faith;
      extraModules = [
        self.nixosModules.vm-baseline
        ({...}: { 
          mySystem.gnome.enable = false;
          mySystem.caelestia.enable = true;
        })
      ];
    };

    # Dream VM
    dream-vm = self.lib.mkHost {
      module = self.nixosModules.host-dream;
      user = "amani";
      homeModule = self.homeModules.user-amani;
      extraModules = [
        self.nixosModules.vm-baseline
        ({...}: { })
      ];
    };
  };
}
