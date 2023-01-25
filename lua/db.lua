vim.keymap.set('n', '<leader>du', '<Cmd>DBUIToggle<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>df', '<Cmd>DBUIFindBuffer<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>dr', '<Cmd>DBUIRenameBuffer<CR>', { silent = true, noremap = true })
vim.keymap.set('n', '<leader>dl', '<Cmd>DBUILastQueryInfo<CR>', { silent = true, noremap = true })

vim.g.db_ui_save_location = '~/.config/db_ui'
