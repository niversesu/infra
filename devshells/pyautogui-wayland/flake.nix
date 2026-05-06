{
  description = "KavyanshKhaitan2/pyautogui";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pyautogui-src = {
      url = "github:KavyanshKhaitan2/pyautogui/431ea6aa62aad5734c9e6bca1edde60b38e736e8";
      flake = false;
    };
    pydotool-src = {
      url = "github:Antares0982/pydotool";
      flake = false;
    };
    wayland-automation-src = {
      url = "github:OTAKUWeBer/Wayland-automation";
      flake = false;
    };
    pyscreeze-src = {
      url = "github:asweigart/pyscreeze";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, pyautogui-src, pydotool-src, wayland-automation-src, pyscreeze-src }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          python-ydotool = pkgs.python3Packages.buildPythonPackage {
            pname = "python-ydotool";
            version = "1.1.1";
            src = pydotool-src;
            pyproject = true;

            build-system = with pkgs.python3Packages; [ setuptools ];
            nativeBuildInputs = [ pkgs.cmake pkgs.pkg-config ];
            dontUseCmakeConfigure = true;

            doCheck = false;
          };

          wayland-automation = pkgs.python3Packages.buildPythonPackage {
            pname = "wayland-automation";
            version = "0.2.7";
            src = wayland-automation-src;
            pyproject = true;

            build-system = with pkgs.python3Packages; [ setuptools ];
            propagatedBuildInputs = with pkgs.python3Packages; [ evdev ];

            doCheck = false;
          };

          pyscreeze = pkgs.python3Packages.buildPythonPackage {
            pname = "pyscreeze";
            version = "1.0.1";
            src = pyscreeze-src;
            pyproject = true;

            build-system = with pkgs.python3Packages; [ setuptools ];
            propagatedBuildInputs = with pkgs.python3Packages; [ pillow ];

            postPatch = ''
              sed -i "s/__version__ = '1.0.0'/__version__ = '1.0.1'/" pyscreeze/__init__.py
            '';

            doCheck = false;
          };

        in {
          default = pkgs.python3Packages.buildPythonPackage {
            pname = "pyautogui";
            version = "0.9.54";
            src = pyautogui-src;
            pyproject = true;

            build-system = with pkgs.python3Packages; [ setuptools ];

            propagatedBuildInputs = with pkgs.python3Packages; [
              pillow
              pyscreenshot
              pytweening
              python-ydotool
              wayland-automation
              pyscreeze
            ];

            doCheck = false;
          };
        });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pyautogui = self.packages.${system}.default;
        in {
          default = pkgs.mkShell {
            packages = [
              (pkgs.python3.withPackages (_: [ pyautogui ]))
              pkgs.wtype
            ];
          };
        });
    };
}
