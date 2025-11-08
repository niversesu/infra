{
  description = "Flake packaging GoLogin AppImage from gologin.tar (no .AppImage suffix)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    
    gologinTar = pkgs.fetchurl {
      url = "https://dl.gologin.com/gologin.tar";
      sha256 = "sha256-O2T+/6qZsa3GWeyA0fSsGaKb8DCPDLX40fChPyLk1ug=";
    };
    
    gologinLogo = pkgs.fetchurl {
      url = "https://play-lh.googleusercontent.com/l7QfbzL4WA86ed1Op87TOAPn4Kx30vMYnczwPYq6A5H1MGB7CIigSdv-uYo4xiA_SQ=w240-h480-rw";
      sha256 = "05ks8a4syispkh2v2rbvszk7niai8kgx9z2p1w9pn8a7kb6mifjc";
    };
    
    gologinAppImage = pkgs.stdenv.mkDerivation {
      name = "gologin-appimage";
      src = gologinTar;
      
      unpackPhase = ''
        tar -xf $src
      '';
      
      installPhase = ''
        mkdir -p $out
        cp GoLogin-* $out/gologin.AppImage
      '';
    };
  in {
    packages.${system}.gologin = pkgs.appimageTools.wrapType2 {
      pname = "gologin";
      version = "latest";
      src = "${gologinAppImage}/gologin.AppImage";
      
      extraInstallCommands = ''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor/256x256/apps
        cp ${gologinLogo} $out/share/icons/hicolor/256x256/apps/gologin.png
        
        cat > $out/share/applications/gologin.desktop <<EOF
[Desktop Entry]
Name=GoLogin
Comment=Multi-accounting browser
Exec=$out/bin/gologin
Icon=gologin
Terminal=false
Type=Application
Categories=Network;WebBrowser;
EOF
      '';
    };

    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.gologin}/bin/gologin";
    };
  };
}


