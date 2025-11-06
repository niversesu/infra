{
  config,
  pkgs,
  ...
}: {
  services = {
    keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            muhenkan = "leftmeta";
            shift = "layer(shift)";
            katakanahiragana = "layer(katakanahiragana)";
          };
          shift = {
            f = "g";
            j = "h";
	    f1 = "esc";
	    down = "up";
          };
          katakanahiragana = {
            semicolon = "apostrophe";
          };
        };
      };
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
    xserver = {
      enable = true;
        desktopManager.gnome.enable = true;
        displayManager.sddm.enable = true;
	displayManager.sddm.wayland.enable = true;
  	desktopManager.plasma6.enable = true;
    };
    getty.autologinUser = "niver";
    flatpak.enable = true;
    upower.enable = true;
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
    ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
    virt-manager.enable = true;
  };

  virtualisation = {
    waydroid.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}


