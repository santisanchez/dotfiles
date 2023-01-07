-- Install packer
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
      require("pluginconfig/nvim-navic")
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    config = function()
      require("pluginconfig/nvim-cmp")
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
          require("pluginconfig/cmp-dictionary")
        end,
      },
      { "saadparwaiz1/cmp_luasnip" },
      { "ray-x/cmp-treesitter" },
      { "lukas-reineke/cmp-rg" },
      { "lukas-reineke/cmp-under-comparator" },
      {
        "onsails/lspkind-nvim",
        config = function()
          require("pluginconfig/lspkind-nvim")
        end,
      },
    },
  },


  -- {
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     'williamboman/mason.nvim',
  --     'williamboman/mason-lspconfig.nvim',
  --     'j-hui/fidget.nvim',
  --     'folke/neodev.nvim',
  --   }
  -- },
  -- Language Server Protocol(LSP)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre" },
    config = function()
      require("pluginconfig/nvim-lspconfig")
    end,
    dependencies = {
      {
        "folke/neoconf.nvim",
        config = function()
          require("pluginconfig/neoconf")
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("pluginconfig/mason-lspconfig")
        end,
      },
      { "weilbith/nvim-lsp-smag" },
    },
  },


  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VimEnter" },
    build = ":TSUpdate",
    config = function()
      require("pluginconfig/nvim-treesitter")
    end,
    dependencies = {
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "nvim-treesitter/nvim-treesitter-refactor" },
      { "nvim-treesitter/nvim-tree-docs" },
      { "vigoux/architext.nvim" },
      { "yioneko/nvim-yati" },
    },
  },

    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
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
			require("pluginconfig/gitsigns")
		end,
	},

  'navarasu/onedark.nvim', -- Theme inspired by Atom
{
		"nvim-lualine/lualine.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/lualine")
		end,
	},
{
		"lukas-reineke/indent-blankline.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/indent-blankline")
		end,
	},
  -- "gc" to comment visual regions/lines
{
		"numToStr/Comment.nvim",
		event = "VimEnter",
		config = function()
			require("pluginconfig/Comment")
		end,
	},
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- Fuzzy Finder (files, lsp, etc)

  { "nvim-lua/plenary.nvim" },
  { "kkharji/sqlite.lua" },

  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    config = function()
      require("pluginconfig/telescope")
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require("telescope").load_extension("frecency")
        end,
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
      -- {
      -- 	"nvim-telescope/telescope-packer.nvim",
      -- 	config = function()
      -- 		require("telescope").load_extension("packer")
      -- 	end,
      -- },
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
      { 'nvim-telescope/telescope-fzf-native.nvim',
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
    keys = { "<leader>bs", "<cmd>YodeCreateSeditorFloating<CR>", mode = "v", noremap = true },
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
			require("pluginconfig/nvim-ts-autotag")
		end,
		dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	},

  { "rafamadriz/friendly-snippets", event = "InsertEnter" },

  { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('refactoring').setup({})
    end
  },
{ "hrsh7th/cmp-cmdline", event = "VimEnter" },
	{ "dmitmel/cmp-cmdline-history", event = "VimEnter" },
  -- { "adalessa/laravel.nvim",
  --     dependencies = {
  --         { "nvim-lua/plenary.nvim" },
  --         { "rcarriga/nvim-notify" },
  --         { "nvim-telescope/telescope.nvim" },
  --     },
  --     config = function()
  --         require("laravel").setup({
  --             split_cmd = "vertical",
  --             split_width = 10,
  --             bind_telescope = true,
  --             ask_for_args = true,
  --         })
  --     end
  -- }

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
			require("pluginconfig/bufferline")
		end,
	},



  { "nvim-telescope/telescope-file-browser.nvim" },

  { "ggandor/leap.nvim" },

  {
    "ThePrimeagen/harpoon",
    keys = { "<leader>a", ":lua require('harpoon.mark').add_file" },
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()

    end
  },

  --   {
  --     "nvim-telescope/telescope-frecency.nvim",
  --     keys = {"<leader><space>", frecency, desc = "[T]elescope [F]recency", noremap = true, silent = true},
  --     config = function()
  --       require "telescope".load_extension("frecency")
  --     end,
  -- dependencies = { "kkharji/sqlite.lua" }
  --   }

}



require("lazy").setup(base_plugins)

-- packer.startup(plugins)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.

-- if is_bootstrap then
--   print '=================================='
--   print '    Plugins are being installed'
--   print '    Wait until Lazy completes,'
--   print '       then restart nvim'
--   print '=================================='
--   return
-- end
-- Automatically source and re-compile packer whenever you save this init.lua
-- local packer_group = vim.api.nvim_create_augroup('LazyInstall', { clear = true })
-- vim.api.nvim_create_autocmd('BufWritePost', {
--   command = 'source <afile> | silent! LspStop | silent! LspStart | Lazy sync',
--   group = packer_group,
--   pattern = vim.fn.expand '$MYVIMRC',
-- })

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd [[colorscheme tokyonight-storm]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    -- icons_enabled = false,
    -- theme = 'tokyonight',
    component_separators = '|',
    section_separators = '',
  },
}

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
-- Gitsigns
-- See `:help gitsigns.txt`
vim.cmd([[:highlight CustomSignsAdd guifg=#a4cf69]])
vim.cmd([[:highlight CustomSignsChange guifg=#63c1e6]])
vim.cmd([[:highlight CustomSignsDelete guifg=#d74f56]])

-- Enable telescope fzf native, if installed

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.



-- Setup mason so it can manage external tooling
-- require('mason').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

-- local servers = {
--   -- clangd = {},
--   -- gopls = {},
--   -- pyright = {},
--   -- rust_analyzer = {},
--   tsserver = {},
--   intelephense = {},

--   sumneko_lua = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   },
-- }

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
-- require('mason').setup()

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'

-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }

-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     }
--   end,
-- }

-- Turn on lsp status information
-- require('fidget').setup()

-- nvim-cmp setup
-- local cmp = require 'cmp'

-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- local luasnip = require 'luasnip'
-- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({
--       reason = cmp.ContextReason.Auto,
--     }), { "i", "c" }), ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }

require('override')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
