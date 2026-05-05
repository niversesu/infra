{self, ...}: {
  flake.homeModules.user-niver = {pkgs, ...}: {
    imports = [
      self.homeModules.shared
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
    myHome.packages.gaming.enable = true;
    myHome.packages.creative.enable = true;
    myHome.packages.tech-tools.enable = true;

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
    };
  };
}
