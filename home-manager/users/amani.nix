{self, inputs, ...}: {
  flake.homeModules.user-amani = {pkgs, ...}: {
    imports = [
      self.homeModules.shared
    ];
    myHome.fish = {
      enable = true;
      flakeTarget = "dream";
      theme = "catppuccin-mocha";
    };
    myHome.theming = {
      enable = true;
      cursorName = "Bibata-Modern-Ice";
    };
    myHome.packages.gaming.enable = true;
    myHome.packages.creative.enable = true;
    myHome.packages.tech-tools.enable = true;
    home.packages = [
      inputs.nix-packages.packages.${pkgs.system}.veadotube-mini
    ];
  };
}
