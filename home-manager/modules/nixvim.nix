{inputs, ...}: {
  flake.homeModules.nixvim = {
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.nixvim.homeModules.nixvim
    ];
    options.myHome.nixvim.enable = lib.mkEnableOption "nixvim";
    config = lib.mkIf config.myHome.nixvim.enable {
      programs.nixvim = {
        enable = true;

        # ── Options ─────────────────────────────────────────────────────────
        opts = {
          number = true;
          relativenumber = true;
          signcolumn = "yes";
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          smartindent = true;
          wrap = false;
          termguicolors = true;
          cursorline = true;
          scrolloff = 8;
          updatetime = 50;
          splitright = true;
          splitbelow = true;
          autoread = true;
        };

        # ── Colorscheme ─────────────────────────────────────────────────────
        colorschemes.catppuccin = {
          enable = true;
          settings.flavour = "mocha";
        };

        # ── Plugins ─────────────────────────────────────────────────────────
        plugins = {
          # UI
          lualine.enable = true;
          bufferline.enable = true;
          web-devicons.enable = true;
          noice.enable = true;
          notify.enable = true;
          dashboard.enable = true;
          dressing.enable = true;
          indent-blankline.enable = true;
          todo-comments.enable = true;
          fidget.enable = true;
          rainbow-delimiters.enable = true;
          zen-mode.enable = true;

          # File tree & navigation
          neo-tree.enable = true;
          harpoon.enable = true;
          flash.enable = true;

          # Fuzzy finding
          telescope = {
            enable = true;
            extensions.fzf-native.enable = true;
          };

          # Treesitter
          treesitter = {
            enable = true;
            settings.highlight.enable = true;
          };
          treesitter-context.enable = true;
          treesitter-textobjects.enable = true;

          # LSP
          lsp = {
            enable = true;
            servers = {
              nil_ls = {
                enable = true;
                settings.nix.autoArchive = true;
              };
              lua_ls.enable = true;
              rust_analyzer = {
                enable = true;
                installCargo = false;
                installRustc = false;
              };
            };
            keymaps = {
              diagnostic = {
                "<leader>d" = "open_float";
                "[d" = "goto_prev";
                "]d" = "goto_next";
              };
              lspBuf = {
                "gd" = "definition";
                "gD" = "declaration";
                "gr" = "references";
                "gi" = "implementation";
                "K" = "hover";
                "<leader>rn" = "rename";
                "<leader>ca" = "code_action";
              };
            };
          };
          lsp-lines.enable = true;
          lspkind.enable = true;

          # Completion
          cmp = {
            enable = true;
            settings = {
              sources = [
                {name = "nvim_lsp";}
                {name = "luasnip";}
                {name = "path";}
                {name = "buffer";}
              ];
              mapping = {
                "<C-Space>" = "cmp.mapping.complete()";
                "<C-e>" = "cmp.mapping.abort()";
                "<CR>" = "cmp.mapping.confirm({ select = true })";
                "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              };
            };
          };
          cmp-nvim-lsp.enable = true;
          cmp-path.enable = true;
          cmp-buffer.enable = true;
          cmp_luasnip.enable = true;
          luasnip.enable = true;
          friendly-snippets.enable = true;

          # Git
          gitsigns.enable = true;
          neogit.enable = true;
          diffview.enable = true;

          # Editing
          vim-surround.enable = true;
          nvim-autopairs.enable = true;
          comment-nvim.enable = true;
          which-key.enable = true;
          trouble.enable = true;

          # Terminal
          toggleterm = {
            enable = true;
            settings = {
              direction = "float";
              float_opts.border = "curved";
            };
          };
        };

        # ── Keymaps ──────────────────────────────────────────────────────────
        globals.mapleader = " ";

        keymaps = [
          # ── File tree ───────────────────────────────────────────────────
          {
            key = "<C-n>";
            action = "<cmd>Neotree toggle<CR>";
            mode = "n";
            options.silent = true;
          }

          # ── Telescope ───────────────────────────────────────────────────
          {
            key = "<leader>ff";
            action = "<cmd>Telescope find_files<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>fg";
            action = "<cmd>Telescope live_grep<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>fb";
            action = "<cmd>Telescope buffers<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>fh";
            action = "<cmd>Telescope help_tags<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>fd";
            action = "<cmd>Telescope diagnostics<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>fr";
            action = "<cmd>Telescope oldfiles<CR>";
            mode = "n";
            options.silent = true;
          } # recent files

          # ── Harpoon ─────────────────────────────────────────────────────
          {
            key = "<leader>ha";
            action = "<cmd>lua require('harpoon.mark').add_file()<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>hh";
            action = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>h1";
            action = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>h2";
            action = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>h3";
            action = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>";
            mode = "n";
            options.silent = true;
          }

          # ── Git ─────────────────────────────────────────────────────────
          {
            key = "<leader>gg";
            action = "<cmd>Neogit<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>gd";
            action = "<cmd>DiffviewOpen<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>gh";
            action = "<cmd>DiffviewFileHistory<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>gb";
            action = "<cmd>Gitsigns blame_line<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "]g";
            action = "<cmd>Gitsigns next_hunk<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "[g";
            action = "<cmd>Gitsigns prev_hunk<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>gp";
            action = "<cmd>Gitsigns preview_hunk<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>gr";
            action = "<cmd>Gitsigns reset_hunk<CR>";
            mode = "n";
            options.silent = true;
          }

          # ── Trouble ─────────────────────────────────────────────────────
          {
            key = "<leader>xx";
            action = "<cmd>TroubleToggle<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>xw";
            action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
            mode = "n";
            options.silent = true;
          }

          # ── Terminal ────────────────────────────────────────────────────
          {
            key = "<C-t>";
            action = "<cmd>ToggleTerm<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-t>";
            action = "<cmd>ToggleTerm<CR>";
            mode = "t";
            options.silent = true;
          } # also works inside terminal

          # ── Buffer navigation ───────────────────────────────────────────
          {
            key = "<S-l>";
            action = "<cmd>BufferLineCycleNext<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<S-h>";
            action = "<cmd>BufferLineCyclePrev<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>bd";
            action = "<cmd>bd<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>bo";
            action = "<cmd>BufferLineCloseOthers<CR>";
            mode = "n";
            options.silent = true;
          } # close all other buffers

          # ── Window splits ───────────────────────────────────────────────
          {
            key = "<leader>sv";
            action = "<cmd>vsplit<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>sh";
            action = "<cmd>split<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-h>";
            action = "<C-w>h";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-l>";
            action = "<C-w>l";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-j>";
            action = "<C-w>j";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-k>";
            action = "<C-w>k";
            mode = "n";
            options.silent = true;
          }
          # resize with arrows
          {
            key = "<C-Up>";
            action = "<cmd>resize +2<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-Down>";
            action = "<cmd>resize -2<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-Left>";
            action = "<cmd>vertical resize -2<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-Right>";
            action = "<cmd>vertical resize +2<CR>";
            mode = "n";
            options.silent = true;
          }

          # ── Editing conveniences ────────────────────────────────────────
          # find & replace with confirmation
          {
            key = "<leader>r";
            action = ":%s/\\<<C-r><C-w>\\>//g<Left><Left>";
            mode = "n";
            options.silent = false;
          }
          # redo
          {
            key = "r";
            action = "<C-r>";
            mode = "n";
            options.silent = true;
          }
          # stay in indent mode after shifting
          {
            key = "<";
            action = "<gv";
            mode = "v";
            options.silent = true;
          }
          {
            key = ">";
            action = ">gv";
            mode = "v";
            options.silent = true;
          }
          # move selected lines up/down
          {
            key = "<A-j>";
            action = "<cmd>m .+1<CR>==";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<A-k>";
            action = "<cmd>m .-2<CR>==";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<A-j>";
            action = ":m '>+1<CR>gv=gv";
            mode = "v";
            options.silent = true;
          }
          {
            key = "<A-k>";
            action = ":m '<-2<CR>gv=gv";
            mode = "v";
            options.silent = true;
          }
          # paste without clobbering register
          {
            key = "p";
            action = "\"_dP";
            mode = "v";
            options.silent = true;
          }
          # keep cursor centred when jumping / searching
          {
            key = "<C-d>";
            action = "<C-d>zz";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<C-u>";
            action = "<C-u>zz";
            mode = "n";
            options.silent = true;
          }
          {
            key = "n";
            action = "nzzzv";
            mode = "n";
            options.silent = true;
          }
          {
            key = "N";
            action = "Nzzzv";
            mode = "n";
            options.silent = true;
          }
          # quick-add blank line above/below without entering insert
          {
            key = "<leader>o";
            action = "o<Esc>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>O";
            action = "O<Esc>";
            mode = "n";
            options.silent = true;
          }
          # duplicate line
          {
            key = "<leader>dl";
            action = "yyp";
            mode = "n";
            options.silent = true;
          }
          # select all
          {
            key = "<C-a>";
            action = "gg<S-v>G";
            mode = "n";
            options.silent = true;
          }

          # ── Clipboard ──────────────────────────────────────────────────
          {
            key = "<C-S-c>";
            action = '"+y';
            mode = "v";
            options.silent = true;
          }

          # ── Save / quit ─────────────────────────────────────────────────
          {
            key = "<C-s>";
            action = "<cmd>w<CR>";
            mode = ["n" "i"];
            options.silent = true;
          } # Ctrl+S saves from any mode
          {
            key = "<C-BS>";
            action = "<C-w>";
            mode = "i";
            options.silent = true;
          } # Ctrl+Backspace delete by chunk
          {
            key = "<leader>w";
            action = "<cmd>w<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>wq";
            action = "<cmd>wq<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>q";
            action = "<cmd>q<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>Q";
            action = "<cmd>qa!<CR>";
            mode = "n";
            options.silent = true;
          } # force quit all

          # ── Misc ────────────────────────────────────────────────────────
          {
            key = "<Esc>";
            action = "<cmd>nohl<CR>";
            mode = "n";
            options.silent = true;
          } # clear search highlight
          {
            key = "<leader>z";
            action = "<cmd>ZenMode<CR>";
            mode = "n";
            options.silent = true;
          }
          {
            key = "<leader>td";
            action = "<cmd>TodoTelescope<CR>";
            mode = "n";
            options.silent = true;
          } # browse TODOs
          {
            key = "<leader>e";
            action = "<cmd>checktime<CR>";
            mode = "n";
            options.silent = true;
          } # manually check for file changes
          {
            key = "<leader>a";
            action = "<cmd>w<CR><cmd>!alejandra %<CR><CR><cmd>e<CR>";
            mode = "n";
            options.silent = true;
          } # format with alejandra and reload
        ];
      };
    };
  };
}
