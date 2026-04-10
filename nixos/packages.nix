{ ... }: {
  flake.nixosModules.packages = {
    description = "Common system-wide packages for NixOS";
    imports = [
      ({ pkgs, ... }: {
        environment.systemPackages = with pkgs; [
          fastfetch ripgrep gparted alejandra unzip aria2 eza wget curl
          home-manager wl-clipboard waydroid-helper cpx cachix
        ];
      })
    ];
  };
}
