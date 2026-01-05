{
  config,
  pkgs,
  ...
}: {
  services = {
    keyd = {
      enable = true;
      keyboards.internal = {
        ids = ["0001:0001:d651c513"];
        settings = {
          main = {
            shift = "layer(shift)";
            leftcontrol = "layer(ctrl)";
            katakanahiragana = "apostrophe";
            pageup = "up";
          };
          shift = {
            f = "g";
            j = "h";
            f2 = "esc";
            q = "w";
            x = "s";
            rightcontrol = "leftmeta";
          };
          ctrl = {
            "1" = "2";
          };
        };
      };
      keyboards.external = {
        ids = ["1a2c:0b2a:c4da6b8e"];
        settings = {
          main = {
            numlock = "f11";
            pause = "f12";
          };
        };
      };
    };
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    #desktopManager.plasma6.enable = true;
    getty.autologinUser = "niver";
    flatpak.enable = true;
    upower.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany
  ];

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
    virt-manager.enable = true;
    ydotool.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  environment.variables.YDOTOOL_SOCKET = pkgs.lib.mkForce "/run/user/1000/.ydotool_socket";

  virtualisation = {
    waydroid.enable = true;
    podman.enable = true;
    docker.enable = false;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
}
