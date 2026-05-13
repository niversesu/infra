{self, ...}: {
  flake.homeModules.user-faith = {...}: {
    imports = [
      self.homeModules.shared
    ];

    myHome.profiles.full.enable = true;
    myHome.fish = {
      enable = true;
      theme = "catppuccin-frappe";
    };
    myHome.theming = {
      enable = true;
      cursorName = "Bibata-Modern-Amber";
    };
    myHome.packages.tech-tools.enable = true;
  };
}
