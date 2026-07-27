{inputs, ...}: {
  flake.homeModules.nvf = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.nvf.homeManagerModules.default
    ];
    options.myHome.nvf.enable = lib.mkEnableOption "nvf (Neovim Flake)";
    config = lib.mkIf config.myHome.nvf.enable {
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

      programs.nvf = {
        enable = true;

        settings.vim = {
          viAlias = true;
          vimAlias = true;

          # ── Options ───────────────────────────────────────────────────────
          options = {
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

          # ── Colorscheme ───────────────────────────────────────────────────
          # NOTE: nixvim used colorschemes.rose-pine. nvf themes live under
          # vim.theme (base16-driven). Confirm "rose-pine" is a valid
          # vim.theme.name value for the pinned nvf revision before deploying
          # (check `nvf-print-config` or the options manual) — swap for the
          # closest supported base16 theme if it doesn't build.
          theme = {
            enable = true;
            name = "rose-pine";
            style = "main";
          };

          # ── UI ────────────────────────────────────────────────────────────
          statusline.lualine.enable = true;
          tabline.nvimBufferline.enable = true;
          visuals = {
            nvim-web-devicons.enable = true;
            indent-blankline.enable = true;
            fidget-nvim.enable = true;
            rainbow-delimiters.enable = true;
          };
          ui.noice.enable = true;
          notify.nvim-notify.enable = true;
          dashboard.dashboard-nvim.enable = true;
          notes.todo-comments.enable = true;
          # NOTE: nixvim's `dressing.enable` and `zen-mode.enable` don't have
          # a 1:1 built-in nvf module as of this writing. If you rely on
          # zen-mode specifically, add it via `vim.extraPlugins` instead;
          # dressing.nvim's UI-select improvements are largely superseded by
          # nvf's own vim.ui / mini.pick options.

          # ── File tree & navigation ──────────────────────────────────────
          filetree.neo-tree.enable = true;
          navigation.harpoon.enable = true;
          utility.motion.flash-nvim.enable = true;

          # ── Fuzzy finding ────────────────────────────────────────────────
          telescope = {
            enable = true;
            extensions = [
              {
                name = "fzf-native";
                packages = [];
                setup = {};
              }
            ];
          };

          # ── Treesitter ───────────────────────────────────────────────────
          treesitter = {
            enable = true;
            highlight.enable = true;
            context.enable = true;
            textobjects.enable = true;
          };

          # ── LSP ──────────────────────────────────────────────────────────
          # nvf configures LSP per-language rather than via a flat
          # `lsp.servers` map. Enabling a language module pulls in sane
          # defaults for that language's LSP server; adjust the preset if
          # you need a specific server (e.g. nixd vs nil).
          languages = {
            nix = {
              enable = true;
              lsp.enable = true;
            };
            lua = {
              enable = true;
              lsp.enable = true;
            };
            python = {
              enable = true;
              lsp.enable = true;
            };
            rust = {
              enable = true;
              # rustaceanvim fully manages its own rust-analyzer instance,
              # so lsp.enable must stay off or nvf's assertion fails.
              lsp.enable = false;
              extensions.rustaceanvim.enable = true;
            };
          };

          lsp = {
            enable = true;
            lspkind.enable = true;
            trouble.enable = true;
            mappings = {
              openDiagnosticFloat = "<leader>d";
              previousDiagnostic = "[d";
              nextDiagnostic = "]d";
              goToDefinition = "gd";
              goToDeclaration = "gD";
              listReferences = "gr";
              listImplementations = "gi";
              hover = "K";
              renameSymbol = "<leader>rn";
              codeAction = "<leader>ca";
            };
          };

          # ── Completion ───────────────────────────────────────────────────
          autocomplete.nvim-cmp.enable = true;
          snippets.luasnip.enable = true;

          # ── Git ──────────────────────────────────────────────────────────
          git = {
            gitsigns = {
              enable = true;
              mappings = {
                nextHunk = "]g";
                previousHunk = "[g";
                previewHunk = "<leader>gp";
                resetHunk = "<leader>gr";
                blameLine = "<leader>gb";
              };
            };
            neogit = {
              enable = true;
              mappings.open = "<leader>gg";
            };
          };
          utility.diffview-nvim.enable = true;

          # ── Editing ──────────────────────────────────────────────────────
          utility.surround.enable = true;
          autopairs.nvim-autopairs.enable = true;
          comments.comment-nvim.enable = true;
          binds.whichKey.enable = true;

          # ── Terminal ─────────────────────────────────────────────────────
          terminal.toggleterm = {
            enable = true;
            setupOpts.direction = "float";
          };

          # ── Keymaps ──────────────────────────────────────────────────────
          globals.mapleader = " ";

          keymaps = [
            # ── File tree ─────────────────────────────────────────────────
            {
              key = "<C-n>";
              action = "<cmd>Neotree toggle<CR>";
              mode = "n";
              silent = true;
            }

            # ── Telescope ─────────────────────────────────────────────────
            {
              key = "<leader>ff";
              action = "<cmd>Telescope find_files<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>fg";
              action = "<cmd>Telescope live_grep<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>fb";
              action = "<cmd>Telescope buffers<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>fh";
              action = "<cmd>Telescope help_tags<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>fd";
              action = "<cmd>Telescope diagnostics<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>fr";
              action = "<cmd>Telescope oldfiles<CR>";
              mode = "n";
              silent = true;
            } # recent files

            # ── Harpoon ───────────────────────────────────────────────────
            {
              key = "<leader>ha";
              action = "<cmd>lua require('harpoon.mark').add_file()<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>hh";
              action = "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>h1";
              action = "<cmd>lua require('harpoon.ui').nav_file(1)<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>h2";
              action = "<cmd>lua require('harpoon.ui').nav_file(2)<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>h3";
              action = "<cmd>lua require('harpoon.ui').nav_file(3)<CR>";
              mode = "n";
              silent = true;
            }

            # ── Git ───────────────────────────────────────────────────────
            {
              key = "<leader>gd";
              action = "<cmd>DiffviewOpen<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>gh";
              action = "<cmd>DiffviewFileHistory<CR>";
              mode = "n";
              silent = true;
            }

            # ── Terminal ──────────────────────────────────────────────────
            {
              key = "<C-t>";
              action = "<cmd>ToggleTerm<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-t>";
              action = "<cmd>ToggleTerm<CR>";
              mode = "t";
              silent = true;
            } # also works inside terminal

            # ── Buffer navigation ─────────────────────────────────────────
            {
              key = "<S-l>";
              action = "<cmd>BufferLineCycleNext<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<S-h>";
              action = "<cmd>BufferLineCyclePrev<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>bd";
              action = "<cmd>bd<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>bo";
              action = "<cmd>BufferLineCloseOthers<CR>";
              mode = "n";
              silent = true;
            } # close all other buffers

            # ── Window splits ─────────────────────────────────────────────
            {
              key = "<leader>sv";
              action = "<cmd>vsplit<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>sh";
              action = "<cmd>split<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-h>";
              action = "<C-w>h";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-l>";
              action = "<C-w>l";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-j>";
              action = "<C-w>j";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-k>";
              action = "<C-w>k";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-Up>";
              action = "<cmd>resize +2<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-Down>";
              action = "<cmd>resize -2<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-Left>";
              action = "<cmd>vertical resize -2<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-Right>";
              action = "<cmd>vertical resize +2<CR>";
              mode = "n";
              silent = true;
            }

            # ── Editing conveniences ──────────────────────────────────────
            {
              key = "<leader>r";
              action = ":%s/\\<<C-r><C-w>\\>//g<Left><Left>";
              mode = "n";
              silent = false;
            }
            {
              key = "r";
              action = "<C-r>";
              mode = "n";
              silent = true;
            }
            {
              key = "<";
              action = "<gv";
              mode = "v";
              silent = true;
            }
            {
              key = ">";
              action = ">gv";
              mode = "v";
              silent = true;
            }
            {
              key = "<A-j>";
              action = "<cmd>m .+1<CR>==";
              mode = "n";
              silent = true;
            }
            {
              key = "<A-k>";
              action = "<cmd>m .-2<CR>==";
              mode = "n";
              silent = true;
            }
            {
              key = "<A-j>";
              action = ":m '>+1<CR>gv=gv";
              mode = "v";
              silent = true;
            }
            {
              key = "<A-k>";
              action = ":m '<-2<CR>gv=gv";
              mode = "v";
              silent = true;
            }
            {
              key = "p";
              action = "\"_dP";
              mode = "v";
              silent = true;
            }
            {
              key = "<C-d>";
              action = "<C-d>zz";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-u>";
              action = "<C-u>zz";
              mode = "n";
              silent = true;
            }
            {
              key = "n";
              action = "nzzzv";
              mode = "n";
              silent = true;
            }
            {
              key = "N";
              action = "Nzzzv";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>o";
              action = "o<Esc>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>O";
              action = "O<Esc>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>dl";
              action = "yyp";
              mode = "n";
              silent = true;
            }
            {
              key = "<C-a>";
              action = "gg<S-v>G";
              mode = "n";
              silent = true;
            }

            # ── Clipboard ─────────────────────────────────────────────────
            {
              key = "<C-S-c>";
              action = "\"+y";
              mode = "v";
              silent = true;
            }

            # ── Save / quit ───────────────────────────────────────────────
            {
              key = "<C-s>";
              action = "<cmd>w<CR>";
              mode = ["n" "i"];
              silent = true;
            }
            {
              key = "<C-BS>";
              action = "<C-w>";
              mode = "i";
              silent = true;
            }
            {
              key = "<leader>w";
              action = "<cmd>w<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>wq";
              action = "<cmd>wq<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>q";
              action = "<cmd>q<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>Q";
              action = "<cmd>qa!<CR>";
              mode = "n";
              silent = true;
            }

            # ── Misc ──────────────────────────────────────────────────────
            {
              key = "<Esc>";
              action = "<cmd>nohl<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>td";
              action = "<cmd>TodoTelescope<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>e";
              action = "<cmd>checktime<CR>";
              mode = "n";
              silent = true;
            }
            {
              key = "<leader>a";
              action = "<cmd>w<CR><cmd>!alejandra %<CR><CR><cmd>e<CR>";
              mode = "n";
              silent = true;
            } # format with alejandra and reload
          ];
        };
      };
    };
  };
}
