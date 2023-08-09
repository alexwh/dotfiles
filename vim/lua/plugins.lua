local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- the colorscheme should be available when starting Neovim
  {"morhetz/gruvbox",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  {"folke/which-key.nvim", event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = { }
  },

  {"folke/neoconf.nvim", cmd = "Neoconf"},

  "folke/neodev.nvim",

  {'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
      {'nvim-tree/nvim-web-devicons', lazy = true},
    },
    config = function()
      require('telescope').setup {}
      require('telescope').load_extension('fzf')
    end,
  },


  {'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', lazy = true },
    opts = {theme = "gruvbox"}
  },

  {'akinsho/bufferline.nvim', version = "*",
    dependencies = {'nvim-tree/nvim-web-devicons', lazy = true},
  },

  { "tiagovla/scope.nvim" },

  {"nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup {
        ensure_installed = { "lua", "vim", "vimdoc", "query", "html" },
        ignore_install = { "gitcommit" },
        auto_install = true,
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

        },
      }
    end
  },

  {'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip', version = "2.*"},     -- Required
    }
  },

  {"L3MON4D3/LuaSnip",
    dependencies = {"rafamadriz/friendly-snippets"}
  },

  {'hrsh7th/nvim-cmp',
    config = function ()
      require'cmp'.setup {
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },

        sources = {
          { name = 'luasnip' },
          -- more sources
        },
      }
    end
  },
  "saadparwaiz1/cmp_luasnip",

  "tpope/vim-unimpaired",
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "tpope/vim-repeat",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "junegunn/vim-easy-align",
  "mbbill/undotree",
  "tommcdo/vim-exchange",
  "wellle/targets.vim",
  "francoiscabrol/ranger.vim",
}
