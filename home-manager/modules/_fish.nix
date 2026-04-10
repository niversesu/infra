{ flakeTarget, theme, ...}: { pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza --all --icons --color=auto --time-style=iso --classify";
      snrs = "sudo nixos-rebuild switch --flake ~/infra/home-manager#${flakeTarget}";
    };
    interactiveShellInit = ''
      fish_config theme choose ${theme}
    '';
  };
}
