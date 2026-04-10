{ self, ... }: {
  flake.homeModules.pkg-media = {
    description = "Media players: VLC, MPV";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ vlc mpv ];
    }) ];
  };
}
