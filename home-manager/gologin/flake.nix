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


