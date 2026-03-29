{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza";
      snrs = "sudo nixos-rebuild switch --flake ~/infra/home-manager#niver";
    };
  };

  programs.fish.interactiveShellInit = ''
    fish_config theme choose catppuccin-mocha
  '';
}
