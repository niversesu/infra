{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza";
      snrs = "sudo nixos-rebuild switch";
      hs = "home-manager switch";
    };
  };

  programs.fish.interactiveShellInit = ''
    fish_config theme choose "Catppuccin Frappe"
  '';
}
