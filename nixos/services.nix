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
            katakanahiragana = "apostrophe";
            rightcontrol = "leftalt";
            pageup = "up";
          };
          shift = {
            f = "g";
            j = "h";
            f1 = "esc";
          };
        };
      };
    };
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
    };
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
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
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
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
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
  systemd.services.ydotoold = {
    description = "Ydotool Daemon";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      ExecStart = "${pkgs.ydotool}/bin/ydotoold \
        --socket-path=/run/ydotoold/ydotool_socket \
        --socket-perm=0666";
      Restart = "always";
      User = "root";
    };
  };

  environment.variables.YDOTOOL_SOCKET = "/run/ydotoold/ydotool_socket";
}
