{ pkgs, ... }: {
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        neovim
        git
      ];
    };
  };
}
