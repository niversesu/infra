{
  self,
  inputs,
  ...
}: {
  flake.homeModules.user-amani = {pkgs, ...}: {
    imports = [
      self.homeModules.shared
    ];
    myHome.profiles.full.enable = true;
    myHome.profiles.creative.enable = true;
    myHome.fish = {
      enable = true;
      theme = "catppuccin-mocha";
    };
    myHome.theming = {
      enable = true;
      cursorName = "Bibata-Modern-Ice";
    };
    myHome.packages.gaming.enable = true;
    myHome.packages.tech-tools.enable = true;
    home.packages = [
      inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.veadotube-mini
    ];
  };
}
