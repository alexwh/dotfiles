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

  {'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
      {'nvim-tree/nvim-web-devicons', lazy = true},
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = { theme = "ivy" },
          live_grep = { theme = "ivy" },
          git_files = { theme = "ivy" }
        },
      }
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

  {
    {'williamboman/mason.nvim', opts = true},
    {'williamboman/mason-lspconfig.nvim',
      opts = {
        automatic_installation = true,
        ensure_installed = {
          "ansiblels",
          "awk_ls",
          "bashls",
          "clangd",
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "html",
          "java_language_server",
          "eslint",
          "jqls",
          "jsonls",
          "lua_ls",
          "ruff",
          "yamlls",
          "terraformls"
        },
        handlers = {
          -- The first entry (without a key) will be the default handler
          -- and will be called for each installed server that doesn't have
          -- a dedicated handler.
          function (server_name) -- default handler (optional)
              require("lspconfig")[server_name].setup {}
          end,

          ["yamlls"] = function ()
              require'lspconfig'.yamlls.setup{
                schemaStore = {
                  url = "https://www.schemastore.org/api/json/catalog.json",
                  enable = true,
                },
                schemas = {
                  ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
                  ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.0/all.json"] = "k8s/**",
                },
              }
          end,
          ["ruff"] = function ()
            require'lspconfig'.ruff.setup{
              init_options = { settings = { lint = {
                ignore = {"E226","E302","E501","E111","E114","E221","E241","E305"}
              }}}
            }
          end
        }
      }
    },
    {'neovim/nvim-lspconfig'}
  },

  {"folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',

    -- use a release tag to download pre-built binaries
    version = 'v0.*',
    opts = {
      keymap = { preset = 'super-tab' },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
      },
      signature = { enabled = true },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          -- dont show LuaLS require statements when lazydev has items
          lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
      },
    },
  },

  {"j-hui/fidget.nvim", tag = "legacy", event = "LspAttach"},

  {"folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = { enabled = false, },
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
  { 'echasnovski/mini.align',       version = false, opts = {
    mappings = {
      start_with_preview = "<CR>"
    }
  }},
  { 'echasnovski/mini.comment',     version = false,
    opts = {
      options = {
        ignore_blank_line = true,
      }
    }
  },
  { 'echasnovski/mini.files',       version = false,
    opts = {
      windows = { preview = true }
    },
    keys = {
      -- open directory of current file (in a last used state) with focus on that file.
      { "-", mode = { "n" }, function() if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end end, desc = "Toggle MiniFiles" },
    },
    lazy = false
  },
  { 'echasnovski/mini.indentscope', version = false, opts = {
    draw = {
      animation = function() return 10 end,
    },
    symbol = '┃',
  }},
  { 'echasnovski/mini.move',        version = false, opts = true },
  { 'echasnovski/mini.operators',   version = false, opts = { evaluate = { prefix = '' } } },
  { 'echasnovski/mini.splitjoin',   version = false, opts = true },
  { 'echasnovski/mini.surround',    version = false,
    opts = {
      mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',

        -- Add this only if you don't want to use extended mappings
        suffix_last = '',
        suffix_next = '',
      }
    },
    keys = {
      -- Remap adding surrounding to Visual mode selection
      { "ys", "", mode = "x" },
      { "S", ":<C-u>lua MiniSurround.add('visual')<CR>", mode = "x", { silent = true } },
      -- Make special mapping for "add surrounding for line"
      { "yss", "ys_", { remap = true } },
    },
  },

  "tpope/vim-repeat",
  "tpope/vim-speeddating",
  "tpope/vim-sleuth",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-unimpaired",
  "shumphrey/fugitive-gitlab.vim",
  "mbbill/undotree",
}
