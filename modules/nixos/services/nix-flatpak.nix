{inputs, ...}: {
  flake.nixosModules.nix-flatpak = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.nix-flatpak.enable = lib.mkEnableOption "nix-flatpak";
    config = lib.mkIf config.mySystem.nix-flatpak.enable {
      services.flatpak.enable = true;
    };
  };
}
