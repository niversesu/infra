{
  # Enable Plasma 
  services.desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
  services.displayManager.plasma-login-manager = {
    enable = true;
  };
  programs.kdeconnect.enable = true;
}
