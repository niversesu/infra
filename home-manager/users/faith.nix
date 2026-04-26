{self, ...}: {
  flake.homeModules.user-faith = {...}: {
    imports = [
      self.homeModules.nixvim
      self.homeModules.fish
      self.homeModules.theming
      self.homeModules.starship
      self.homeModules.git
      self.homeModules.vscode
      self.homeModules.xdg
      self.homeModules.illogical
      self.homeModules.spicetify
      self.homeModules.packages
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

    home = {
      username = "faith";
      homeDirectory = "/home/faith";
      stateVersion = "25.05";
    };
    nixpkgs.config.allowUnfree = true;
  };
}
