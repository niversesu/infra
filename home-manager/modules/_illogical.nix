{
  config,
  inputs,
  pkgs,
  hyprland-plugins,
  ...
}: {
  programs.illogical-impulse = {
    enable = true;

    # Customize shell tools (all enabled by default)
    dotfiles = {
      fish.enable = true; # Fish shell with custom config
      kitty.enable = true; # Kitty terminal emulator
      starship.enable = true; # Starship prompt
    };
    hyprland.plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
    
  };
}
