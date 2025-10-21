{
  config,
  pkgs,
  ...
}: {
  services = {

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    getty.autologinUser = "niver";
    flatpak.enable = true;
    upower.enable = true;

    # Chrome Remote Desktop service
    #chrome-remote-desktop = {
      #enable = true;
      #user = "niver";  # Updated to use your username instead of "sepiabrown"
    #};
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
	obs-composite-blur
      ];
    };
  };

  virtualisation = {
    waydroid.enable = true;
  };
}

