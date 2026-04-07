{
  config,
  inputs,
  pkgs,
  hyprland-plugins,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.mySystem.illogical.enable or false) {
    programs.illogical-impulse = {
      enable = true;
      dotfiles = {
        fish.enable = true;
        kitty.enable = true;
        starship.enable = true;
      };
      hyprland.plugins = [
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      ];
    };
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };
}
