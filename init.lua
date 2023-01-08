-- Disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    -- "matchit",
    "matchparen",
    "tar",
    "tarPlugin",
    "rrhelper",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

--Install lazy
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


-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

  { "MunifTanjim/nui.nvim" },

  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    branch = "main",
    keys = {
      { "<leader>t", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("config/neo-tree")
    end,
  },

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

  -- Language Server Protocol(LSP)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      require("config/nvim-lspconfig")
    end,
    dependencies = {
      -- {
      --   "folke/neoconf.nvim",
      --   config = function()
      --     require("config/neoconf")
      --   end,
      -- },
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

  -- Git related plugins
  { 'tpope/vim-fugitive', cmd = "Git" },
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    config = function()
      require("config/gitsigns")
    end,
  },

  'navarasu/onedark.nvim', -- Theme inspired by Atom
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
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
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
        config = function()
          require("config/harpoon")
          require("telescope").load_extension("harpoon")
        end
      },
      { "adalessa/laravel.nvim",
        config = function()
          require('config/laravel_config')
          require("telescope").load_extension "laravel"
        end,
        dependencies = {
          { "nvim-lua/plenary.nvim" },
          { "rcarriga/nvim-notify" },
          { "nvim-telescope/telescope.nvim" },
        },
        keys = { "<leader>sl", "<Cmd>Telescope laravel<CR>", noremap = true, silent = true },
      },
      {
        "nvim-telescope/telescope-github.nvim",
        config = function()
          require("telescope").load_extension("gh")
        end,
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end,
      },
      {
        "crispgm/telescope-heading.nvim",
        config = function()
          require("telescope").load_extension("heading")
        end,
      },
      {
        "LinArcX/telescope-changes.nvim",
        config = function()
          require("telescope").load_extension("changes")
        end,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        config = function()
          require("telescope").load_extension("live_grep_args")
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
        "nvim-telescope/telescope-media-files.nvim",
        enabled = function()
          return vim.fn.executable("ueberzug")
        end,
        config = function()
          require("telescope").load_extension("media_files")
        end,
      },
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
  -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available,

  { 'folke/tokyonight.nvim' },
  { "nathom/filetype.nvim" },
  {
    'hoschi/yode-nvim',
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

  { "rafamadriz/friendly-snippets", event = "InsertEnter" },

  { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },

  { "hrsh7th/cmp-cmdline", event = "VimEnter" },
  { "dmitmel/cmp-cmdline-history", event = "VimEnter" },

  { "napmn/react-extract.nvim",
    keys = { "<leader>rp", ":lua require('custom').extract_to_new_file()<CR>" },
    config = function()
      require("react-extract").setup()
    end },


  {
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    enabled = function()
      return not vim.g.vscode
    end,
    config = function()
      require("config/bufferline")
    end,
  },

  -- Local plugins
  -- {
  --   name = "laravel-completions",
  --   dir = "~/Projects/neovim/laravel-completions",
  --   dev = true
  -- },
}



require("lazy").setup(base_plugins)

-- Enable telescope fzf native, if installed

require('options')
require('autocmds')
require('mappings')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
