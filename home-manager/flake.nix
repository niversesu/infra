{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    nixvim,
    nur,
    import-tree,
    ...
  }: let
    system = "x86_64-linux";

    overlays = [nur.overlays.default];

    pkgs = import nixpkgs {
      inherit system overlays;
      config = {allowUnfree = true;};
    };

    kubectl-aliases = pkgs.fetchFromGitHub {
      owner = "ahmetb";
      repo = "kubectl-aliases";
      rev = "master";
      sha256 = "sha256-NkprSk55aRVHiq9JXduQl6AGZv5pBLHznRToOdm9OUw=";
    };

    commonSpecialArgs = {
      inherit spicetify-nix nixvim kubectl-aliases system pkgs;
      inherit nur import-tree;
      inputs = self.inputs;
    };
  in {
    nixosConfigurations."niver" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = commonSpecialArgs;
      modules = [
        home-manager.nixosModules.home-manager
        ../hosts/niver.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = commonSpecialArgs;
          home-manager.users.niver = import ./home-manager/users/niver.nix;
          home-manager.sharedModules = [
            spicetify-nix.homeManagerModules.default
          ];
        }
      ];
    };
    nixosConfigurations."faith" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = commonSpecialArgs;
      modules = [
        home-manager.nixosModules.home-manager
        ../hosts/faith.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = commonSpecialArgs;
	  home-manager.users.faith = import ./home-manager/users/faith.nix;
	  home-manager.sharedModules = [
            spicetify-nix.homeManagerModules.default
          ];
        }
      ];
    };
  };
}
