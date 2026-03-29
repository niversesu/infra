{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza";
      snrs = "sudo nixos-rebuild switch --flake ~/infra/home-manager#faith";
    };
  };

  programs.fish.interactiveShellInit = ''
    fish_config theme choose catppuccin-frappe
  '';
}
