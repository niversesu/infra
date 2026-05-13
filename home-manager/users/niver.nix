{self, ...}: {
  flake.homeModules.user-niver = {
    pkgs,
    inputs,
    ...
  }: {
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
    home.packages = [
      inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.veadotube-mini
    ];

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
    };
  };
}
