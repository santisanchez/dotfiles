-- System Clipboard
-- vim.opt.clipboard = 'unnamedplus'
vim.cmd [[colorscheme onedark]]
vim.opt.showtabline = 2

vim.opt.guifont = "FiraCode NF:h15"
-- Offset on scroll
vim.opt.scrolloff = 5
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.lazyredraw = true
-- Relative line numbers
vim.wo.relativenumber = true

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
vim.o.completeopt = 'menu,menuone,noselect'


-- local null_ls = require("null-ls")
-- local laravel_actions = require("laravel.code-actions")
-- null_ls.setup({
--     sources = {
--         -- null_ls.builtins.formatting.prettier,
--         null_ls.builtins.code_actions.refactoring,
--         null_ls.builtins.code_actions.gitsigns,
--         -- laravel_actions.relationships
--     },
-- })
