{
  description = "Home Manager + NixOS configuration of niver";

  inputs = {
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    better-control.url = "github:rishabh5321/better-control-flake";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gologin = {
      url = "path:./gologin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    caelestia-shell,
    better-control,
    nixvim,
    nur,
    gologin,
    ...
  }: let
    system = "x86_64-linux";

    overlays = [
      nur.overlays.default
    ];

    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in {
    # ✅ NixOS system configuration (for nixos-rebuild)
    nixosConfigurations.niver = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
      ./home.nix
      ];
    };

    # ✅ Home Manager standalone config (for home-manager switch)
    homeConfigurations."niver" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit spicetify-nix caelestia-shell better-control nixvim gologin;
      };
      modules = [
        spicetify-nix.homeManagerModules.default
        ./home.nix
      ];
    };
  };
}

