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
  checker = {
    enabled = true,
  },
  -- the colorscheme should be available when starting Neovim
  {"morhetz/gruvbox",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme gruvbox]])
    end,
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

  {'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>k', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>j', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {'nvim-lualine/lualine.nvim',
    dependencies = {'nvim-tree/nvim-web-devicons', lazy = true },
    opts = {theme = "gruvbox"}
  },

  {'akinsho/bufferline.nvim', version = "*",
    dependencies = {'nvim-tree/nvim-web-devicons', lazy = true},
    opts = { options = {
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end
    }},
  },

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
            if lang == "yaml" then
              return true
            end
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

  {"j-hui/fidget.nvim", tag = "legacy", event = "LspAttach"},

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
  {"folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = { enabled = true, },
      },
      label = {
        style = "inline",
        rainbow = { enabled = true, },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "R", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- use opts = true to call setup()
  { 'echasnovski/mini.ai',          version = false, opts = true },
  { 'echasnovski/mini.align',       version = false, opts = true },
  { 'echasnovski/mini.comment',     version = false, opts = {
    options = {
      ignore_blank_line = true,
  }}},
  { 'echasnovski/mini.files',       version = false, opts = {
      windows = { preview = true },
  }},
  { 'echasnovski/mini.indentscope', version = false, opts = {
    draw = {
      animation = function() return 10 end,
    },
    symbol = '┃',
  }},
  { 'echasnovski/mini.move',        version = false, opts = true },
  { 'echasnovski/mini.operators',   version = false, opts = { evaluate = { prefix = '' } } },
  { 'echasnovski/mini.splitjoin',   version = false, opts = true },
  { 'echasnovski/mini.surround',    version = false, opts = true },


  "saadparwaiz1/cmp_luasnip",
  "tpope/vim-repeat",
  "tpope/vim-speeddating",
  "tpope/vim-sleuth",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-unimpaired",
  "shumphrey/fugitive-gitlab.vim",
  "mbbill/undotree",
}
