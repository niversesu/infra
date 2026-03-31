{
  config,
  pkgs,
  ...
}: {
  programs.illogical-impulse = {
    enable = true;

    # Customize shell tools (all enabled by default)
    dotfiles = {
      fish.enable = true; # Fish shell with custom config
      kitty.enable = true; # Kitty terminal emulator
      starship.enable = false; # Starship prompt
    };
    hyprland.plugins = [
      pkgs.hyprlandPlugins.hyprbars
      pkgs.hyprlandPlugins.hyprexpo
      # Add any other plugins available in nixpkgs
    ];
    
  };
}
