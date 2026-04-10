{ self, ... }: {
  flake.homeModules.user-faith = { config, pkgs, lib, ... }: {
    imports = [
      self.homeModules.nixvim
      self.homeModules.fish
      self.homeModules.theming
      self.homeModules.starship
      self.homeModules.git
      self.homeModules.vscode
      self.homeModules.xdg
      self.homeModules.caelestia
      self.homeModules.illogical
      self.homeModules.spicetify
      self.homeModules.pkg-faith-tools
      self.homeModules.pkg-browsers
      self.homeModules.pkg-cli-utilities
      self.homeModules.pkg-communication
      self.homeModules.pkg-creative
      self.homeModules.pkg-file-management
      self.homeModules.pkg-fonts
      self.homeModules.pkg-gaming
      self.homeModules.pkg-media
      self.homeModules.pkg-misc
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
