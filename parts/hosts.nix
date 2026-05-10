{
  self,
  inputs,
  ...
}: let
  mkHost = {
    module,
    user,
    homeModule,
    extraModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self;};
      modules =
        [
          inputs.home-manager.nixosModules.home-manager
          module
          ({...}: {
            nixpkgs.overlays = [inputs.nur.overlays.default];
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs self;};
              users.${user} = homeModule;
            };
          })
        ]
        ++ extraModules;
    };
in {
  flake.nixosConfigurations = {
    kale = mkHost {
      module = self.nixosModules.host-kale;
      user = "niver";
      homeModule = self.homeModules.user-niver;
    };
    nomi = mkHost {
      module = self.nixosModules.host-nomi;
      user = "faith";
      homeModule = self.homeModules.user-faith;
    };
    dream = mkHost {
      module = self.nixosModules.host-dream;
      user = "amani";
      homeModule = self.homeModules.user-amani;
    };
    kale-vm = mkHost {
      module = self.nixosModules.host-kale;
      user = "niver";
      homeModule = self.homeModules.user-niver;
      extraModules = [
        ({lib, ...}: {
          mySystem.host-kale-hw.enable = lib.mkForce false;
          virtualisation.vmVariant.virtualisation = {
            memorySize = 8192;
            cores = 8;
            diskSize = 20480;
          };
          users.users.niver.password = "123";
          virtualisation.vmVariant.virtualisation.qemu.options = [
            "-vga virtio"
            "-display gtk,gl=on"
          ];
          virtualisation.vmVariant.virtualisation.forwardPorts = [
            {
              host.port = 2222;
              guest.port = 22;
            }
          ];
        })
      ];
    };
  };
}
