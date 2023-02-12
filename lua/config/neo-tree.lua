-- See ":help neo-tree-highlights" for a list of available highlight groups
vim.cmd([[
hi link NeoTreeDirectoryName Directory
hi link NeoTreeDirectoryIcon NeoTreeDirectoryName
]])

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require('neo-tree').setup({})
vim.keymap.set("n", "<leader>t", "<Cmd>NeoTreeRevealToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>g", "<Cmd>NeoTreeFloatToggle git_status<CR>", { noremap = true, silent = true })
