{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza --all --icons --color=auto --time-style=iso --classify";
      snrs = "sudo nixos-rebuild switch --flake ~/infra/home-manager#kale";
    };
  };

  programs.fish.interactiveShellInit = ''
    fish_config theme choose catppuccin-mocha
  '';
}
