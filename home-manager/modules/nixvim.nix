{ self, inputs, ... }: {
  flake.homeModules.nixvim = { config, pkgs, ... }: {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin = {
        enable = true;
        settings.style = "default";
      };

      plugins = {
        lualine.enable = true;
        cmp.enable = true;
        vim-surround.enable = true;
        treesitter.enable = true;
        trouble.enable = true;
        which-key.enable = true;
        dashboard.enable = true;
        noice.enable = true;
        notify.enable = true;
        web-devicons.enable = true;
        neo-tree.enable = true;
        telescope.enable = true;
      };

      keymaps = [
        {
          key = "<C-n>";
          action = "<cmd>Neotree toggle<CR>";
          mode = "n"; # normal mode
          options.silent = true;
        }
      ];
    };
  };
}
