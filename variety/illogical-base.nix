{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
  services.geoclue2.enable = true;
  networking.networkmanager.enable = true;
  services.upower.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    qt5.qtgraphicaleffects
    qt6.qt5compat
    qt6.qtpositioning
    kdePackages.syntax-highlighting
    kdePackages.dolphin
  ];
  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
  ];
}
