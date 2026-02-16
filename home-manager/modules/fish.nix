{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      nano = "nvim";
      ls = "eza";
      snrs = "sudo nixos-rebuild switch";
      hs = "home-manager switch";
    };
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "v6.1.1";
          sha256 = "sha256-ZyEk/WoxdX5Fr2kXRERQS1U1QHH3oVSyBQvlwYnEYyc=";
        };
      }
    ];
    interactiveShellInit = ''
      set -gx tide_style Rainbow
      set -gx tide_prompt_colors "True color"
      set -gx tide_show_time "24-hour format"
      set -gx tide_rainbow_prompt_separators Vertical
      set -gx tide_powerline_prompt_heads Round
      set -gx tide_powerline_prompt_tails Round
      set -gx tide_powerline_prompt_style "Two lines, character"
      set -gx tide_prompt_connection Disconnected
      set -gx tide_powerline_right_prompt_frame No
      set -gx tide_prompt_spacing Sparse
      set -gx tide_icons "Many icons"
      set -gx tide_transient Yes
    '';
  };
}
