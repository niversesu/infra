{self, ...}: {
  flake.homeModules.user-faith = {...}: {
    imports = [
      self.homeModules.shared
    ];

    myHome.fish = {
      enable = true;
      flakeTarget = "nomi";
      theme = "catppuccin-frappe";
    };
    myHome.theming = {
      enable = true;
      cursorName = "Bibata-Modern-Amber";
    };
    myHome.packages.tech-tools.enable = true;
  };
}
