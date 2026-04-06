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
    illogical-flake = {
      url = "github:soymou/illogical-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.54.2";  # pin to exactly what you're running
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    nixvim,
    nur,
    import-tree,
    illogical-flake,
    hyprland-plugins,
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
    commonSharedModules = [
      spicetify-nix.homeManagerModules.default
      illogical-flake.homeManagerModules.default
    ];
  in {
    nixosConfigurations."kale" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = commonSpecialArgs;
      modules = [
        home-manager.nixosModules.home-manager
        ../hosts/kale.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = commonSpecialArgs;
          home-manager.users.niver = import ./users/niver.nix;
          home-manager.sharedModules = commonSharedModules;
        }
      ];
    };
    nixosConfigurations."nomi" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = commonSpecialArgs;
      modules = [
        home-manager.nixosModules.home-manager
        ../hosts/nomi.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = commonSpecialArgs;
          home-manager.users.faith = import ./users/faith.nix;
          home-manager.sharedModules = commonSharedModules;
        }
      ];
    };
  };
}
