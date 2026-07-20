{self, ...}: {
  flake.homeModules.user-niver = {
    config,
    pkgs,
    inputs,
    ...
  }: {
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
      inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.delphitools-cli
      inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.antigravity-nix.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli
    ];

    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
    };
  };
}
