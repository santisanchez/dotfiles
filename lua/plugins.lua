local base_plugins = {
  { "folke/lazy.nvim" },
  {
    "williamboman/mason.nvim",
    event = "BufReadPre",
    config = function()
      require("mason").setup({})
    end,
  },

  {
    "SmiteshP/nvim-navic",
    init = function()
      require("config/nvim-navic_config")
    end,
  },

  { "MunifTanjim/nui.nvim", event = "VimEnter" },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    branch = "main",
    config = function()
      require("config/neo-tree")
    end,
  },

  { "Tastyep/structlog.nvim" },
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    config = function()
      require("config/nvim-cmp")
    end,
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "windwp/nvim-autopairs" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      -- { "hrsh7th/cmp-omni" },
      { "hrsh7th/cmp-nvim-lua" },
      -- { "zbirenbaum/copilot-cmp", after = { "nvim-cmp", "copilot.lua" } },
      -- { "hrsh7th/cmp-copilot" },
      { "hrsh7th/cmp-emoji" },
      { "hrsh7th/cmp-calc" },
      { "f3fora/cmp-spell" },
      { "yutkat/cmp-mocword" },
      {
        "uga-rosa/cmp-dictionary",
        config = function()
          require("config/cmp-dictionary")
        end,
      },
      { "saadparwaiz1/cmp_luasnip" },
      { "ray-x/cmp-treesitter" },
      { "lukas-reineke/cmp-rg" },
      { "lukas-reineke/cmp-under-comparator" },
      {
        "onsails/lspkind-nvim",
        config = function()
          require("config/lspkind-nvim")
        end,
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    config = function()
      require("config/luasnip_config")
    end,
  },

  {
    'folke/neodev.nvim',
    event = "VimEnter",
    config = function()
      require('config.neodev_config')
    end
  },
  { 'sindrets/diffview.nvim' },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    lazy = true,
    -- module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  },
  -- Language Server Protocol(LSP)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      require("config/nvim-lspconfig")
    end,
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("config/mason-lspconfig")
        end,
      },
      { "weilbith/nvim-lsp-smag" },
      { 'joechrisellis/lsp-format-modifications.nvim' }
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      require("config/null-ls_config")
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VimEnter" },
    build = ":TSUpdate",
    config = function()
      require("config/nvim-treesitter")
    end,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-tree-docs" },
      { "vigoux/architext.nvim" },
      { "yioneko/nvim-yati" },
    },
  },

  -- run = function()
  --   pcall(require('nvim-treesitter.install').update { with_sync = true })
  -- end,
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter',
    event = "VimEnter"
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- Git related plugins
  { 'tpope/vim-fugitive', cmd = "Git" },
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    config = function()
      require("config/gitsigns")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config/lualine")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VimEnter",
    config = function()
      require("config/indent-blankline")
    end,
  },
  -- "gc" to comment visual regions/lines
  {
    "numToStr/Comment.nvim",
    event = "VimEnter",
    config = function()
      require("config/Comment")
    end,
  },
  -- 'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Fuzzy Finder (files, lsp, etc)

  { "nvim-lua/plenary.nvim" },
  { "kkharji/sqlite.lua" },
  { "rcarriga/nvim-notify", event = "BufReadPre" },
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    keys = {
      { "<leader>e", "<Cmd>Telescope my_mru<CR>", desc = "Telescope recent files on current dir", noremap = true,
        silent = true },
    },
    config = function()
      require("config/telescope_config")
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
      },
      {
        "ThePrimeagen/refactoring.nvim",
        config = function()
          require("config/refactoring")
          require("telescope").load_extension("refactoring")
        end,
      },
      {
        "ThePrimeagen/harpoon",
        keys = {
          { '<leader>a', "<cmd>lua require('harpoon.mark').add_file<CR>", silent = true },
          { '<C-e>', "<cmd>require('harpoon.ui').toggle_quick_menu<CR>", silent = true }
        },
        config = function()
          require("config/harpoon")
          require("telescope").load_extension("harpoon")
        end
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end,
      },
      {
        "nvim-telescope/telescope-smart-history.nvim",
        config = function()
          require("telescope").load_extension("smart_history")
        end,
        build = function()
          os.execute("mkdir -p " .. vim.fn.stdpath("state") .. "databases/")
        end,
      },
      { "nvim-telescope/telescope-symbols.nvim" },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1,
        config = function()
          require('telescope').load_extension('fzf')
        end
      },
    },
  },
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer" },
    keys = {
      { "<leader>pa", ":Artisan<cr>" },
    },
    config = function()
      require("laravel").setup()
      require("telescope").load_extension("laravel")
    end
  },
  { "nathom/filetype.nvim" },
  {
    'hoschi/yode-nvim',
    event = "VimEnter",
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require('yode-nvim').setup({})
    end

  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup {} end
  },

  {
    "windwp/nvim-ts-autotag",
    event = "VimEnter",
    config = function()
      require("config/nvim-ts-autotag")
    end,
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
  },

  { "rafamadriz/friendly-snippets" },

  {
    'nvim-treesitter/playground',
    cmd = "TSPlaygroundToggle"
  },

  { "hrsh7th/cmp-cmdline", event = "VimEnter" },
  { "dmitmel/cmp-cmdline-history", event = "VimEnter" },

  {
    "napmn/react-extract.nvim",
    keys = { "<leader>rp", "<cmd>lua require('custom').extract_to_new_file()<CR>" },
    config = function()
      require("react-extract").setup()
    end
  },

  -- {
  --   "akinsho/bufferline.nvim",
  --   version = 'v3.*',
  --   enabled = function()
  --     return not vim.g.vscode
  --   end,
  --   config = function()
  --     require("config/bufferline")
  --   end,
  -- },
  -- {
  --   "roobert/bufferline-cycle-windowless.nvim",
  --   dependencies = {
  --     { "akinsho/bufferline.nvim" },
  --   },
  --   config = function()
  --     require("bufferline-cycle-windowless").setup({
  --       -- whether to start in enabled or disabled mode
  --       default_enabled = true,
  --     })
  --   end,
  -- },
  {
    "drybalka/tree-climber.nvim",
    event = "VimEnter",
    config = function()
      require('config/tree_climber')
    end
  },

  {
    "folke/noice.nvim",
    config = function()
      require('config/noice_config')
    end,
  },
  { "folke/twilight.nvim", event = "VimEnter",
    config = function()
      require("twilight").setup {
      }
    end
  },
  { "folke/zen-mode.nvim",
    event = "VimEnter",
    config = function()
      require('zen-mode').setup {}
    end
  },
  {
    "chrisgrieser/nvim-recorder",
    config = function() require("recorder").setup() end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure()

    end
  },
  {
    'Exafunction/codeium.vim',
    config = function()
      require("config.codeium_config")
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<c-cr>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true })
    end
  },

  -- Database
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-ui' },

  { 'navarasu/onedark.nvim' },
  { 'lunarvim/onedarker.nvim' }
}

return base_plugins
-- vim: ts=2 sts=2 sw=2 et
