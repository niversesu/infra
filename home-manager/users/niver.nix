{self, ...}: {
  flake.homeModules.user-niver = {pkgs, ...}: {
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
      flakeTarget = "kale";
      theme = "catppuccin-mocha";
    };
    myHome.theming = {
      enable = true;
      cursorName = "Bibata-Modern-Ice";
    };
    my.packages.gaming.enable = true;
    my.packages.tech-tools.enable = true;

    home = {
      username = "niver";
      homeDirectory = "/home/niver";
      stateVersion = "26.05";
    };
    nixpkgs.config.allowUnfree = true;
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
    };
  };
}
