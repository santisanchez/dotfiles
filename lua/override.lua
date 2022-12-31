local null_ls = require("null-ls")
local laravel_actions = require("laravel.code-actions")
local colorscheme = 'onedark'

-- System Clipboard
vim.opt.clipboard = 'unnamedplus'

vim.opt.showtabline = 2

-- Offset on scroll
vim.opt.scrolloff = 5
vim.opt.smartindent = true
vim.opt.cursorline = true

-- Relative line numbers
vim.wo.relativenumber = true

vim.cmd("colorscheme " .. colorscheme)


pcall(require("telescope").load_extension, 'refactoring')
pcall(require('telescope').load_extension, 'laravel')

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case",
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

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
}


require('luasnip').filetype_extend("javascript", { "javascriptreact" })

require("luasnip.loaders.from_vscode").lazy_load({ paths = {
  "~/.local/share/nvim/site/pack/packer/start/friendly-snippets"
} })

require('null-ls').setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
    null_ls.builtins.code_actions.refactoring,
    laravel_actions.relationships
  },
})
pcall(require, 'custom.mappings')
