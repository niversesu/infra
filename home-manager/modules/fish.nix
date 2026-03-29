{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza";
      snrs = "sudo nixos-rebuild switch --flake ~/infra/home-manager";
      hs = "home-manager switch --flake ~/infra/home-manager";
    };
  };

  programs.fish.interactiveShellInit = ''
    fish_config theme choose "Catppuccin Frappe"
  '';
}
