{ ... }: {
  flake.homeModules.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };
}
