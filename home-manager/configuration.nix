# NixOS system configuration
{ config, pkgs, ... }:

{
  # Import the Chrome Remote Desktop module from the local file
  imports = [
    ./chrome-remote-desktop.nix
  ];

  # Enable Chrome Remote Desktop service
  services.chrome-remote-desktop = {
    enable = true;
    user = "niver"; # Replace with your actual username
  };

  # Basic system configuration (you may need to add more based on your system)
  # This is a minimal configuration - you'll likely need to add:
  # - Boot loader configuration
  # - Network configuration  
  # - Hardware configuration
  # - Other system services
  
  # Example minimal config:
  system.stateVersion = "25.05"; # Set to your NixOS version
  
  # You may need to add more configuration here based on your actual system
}