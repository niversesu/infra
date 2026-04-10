{ inputs, ... }: {
  flake.nixosConfigurations = {
    kale = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit (inputs) nixvim spicetify-nix nur import-tree;
        system = "x86_64-linux";
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ../hosts/kale.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
             inherit (inputs) nixvim spicetify-nix nur import-tree;
             inputs = inputs;
             system = "x86_64-linux";
          };
          home-manager.users.niver = import ../home-manager/users/niver.nix;
          home-manager.sharedModules = [
            inputs.spicetify-nix.homeManagerModules.default
            inputs.illogical-flake.homeManagerModules.default
            inputs.caelestia-shell.homeManagerModules.default
          ];
        }
      ];
    };
    nomi = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit (inputs) nixvim spicetify-nix nur import-tree;
        system = "x86_64-linux";
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ../hosts/nomi.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
             inherit (inputs) nixvim spicetify-nix nur import-tree;
             inputs = inputs;
             system = "x86_64-linux";
          };
          home-manager.users.faith = import ../home-manager/users/faith.nix;
          home-manager.sharedModules = [
            inputs.spicetify-nix.homeManagerModules.default
            inputs.illogical-flake.homeManagerModules.default
            inputs.caelestia-shell.homeManagerModules.default
          ];
        }
      ];
    };
  };
}
