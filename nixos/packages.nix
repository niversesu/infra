{ ... }: {
  flake.nixosModules.packages = {
    imports = [
      ({ pkgs, inputs, ... }: {
        environment.systemPackages = with pkgs; [
          fastfetch ripgrep gparted alejandra unzip aria2 eza wget curl
          home-manager wl-clipboard cpx cachix
          inputs.winapps.packages.${pkgs.system}.winapps
        ];
      })
    ];
  };
}
