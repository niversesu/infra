{
  self,
  inputs,
  ...
}: let
  mkHost = {
    module,
    user,
    homeModule,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self;};
      modules = [
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
      ];
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
  };
}
