{ self, ... }: {
  flake.homeModules.vscode = { config, pkgs, lib, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
