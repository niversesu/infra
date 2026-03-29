{
  config,
  pkgs,
  ...
}: {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [epiphany];
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.pano 
    gnomeExtensions.blur-my-shell
  ];
  programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };
}
