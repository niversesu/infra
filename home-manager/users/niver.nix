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
    my.packages.gaming.enable = true;
    my.packages.creative.enable = true;
    my.packages.tech-tools.enable = true;

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
    };
  };
}
