-- System Clipboard
-- vim.opt.clipboard = 'unnamedplus'
vim.cmd [[colorscheme tokyonight-storm]]
vim.opt.showtabline = 2

vim.opt.guifont = "FiraCode NF:h15"
-- Offset on scroll
vim.opt.scrolloff = 5
vim.opt.smartindent = true
vim.opt.cursorline = true

-- Relative line numbers
vim.wo.relativenumber = true

local actions = require "telescope.actions"
local fb_actions = require "telescope".extensions.file_browser.actions
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",
    },
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = false,
      mappings = {
        ["i"] = {
          ["<C-a>"] = fb_actions.create,
          ["<C-d>"] = fb_actions.remove,
          ["<C-x>"] = fb_actions.move,
          ["<C-r>"] = fb_actions.rename,
          ["<C-h>"] = fb_actions.goto_cwd,
          ["<C-p>"] = fb_actions.goto_parent_dir,

        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    }
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous
      },
    },
  },
}

pcall(require("telescope").load_extension, 'refactoring')
pcall(require('telescope').load_extension, 'laravel')
pcall(require("telescope").load_extension, "file_browser")
pcall(require("telescope").load_extension, 'harpoon')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'php', 'javascript', 'tsx', 'typescript', 'help' },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  autotag = {
    enable = true,
  }
}


require('luasnip').filetype_extend("javascript", { "javascriptreact" })

require("luasnip.loaders.from_vscode").lazy_load({ paths = {
  "~/.local/share/nvim/site/pack/packer/start/friendly-snippets"
} })

local null_ls = require("null-ls")
local laravel_actions = require("laravel.code-actions")
require('null-ls').setup({
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.gitsigns,
    laravel_actions.relationships
  },
})
pcall(require, 'custom.mappings')
require('leap').add_default_mappings()
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
