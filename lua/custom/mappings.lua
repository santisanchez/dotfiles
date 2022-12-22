  -- My Mappings
  vim.keymap.set('n', '<C-s>', ':w<CR>', {silent = true})
  vim.keymap.set('n', '<C-h>', '<C-w>h>', {silent = true})
  vim.keymap.set('n', '<C-j>', '<C-w>j>', {silent = true})
  vim.keymap.set('n', '<C-k>', '<C-w>k>', {silent = true})
  vim.keymap.set('n', '<C-l>', '<C-w>l>', {silent = true})

  -- Center to the cursor on screen movement
  vim.keymap.set('n', 'n', 'nzz', {silent = true})
  vim.keymap.set('n', 'N', 'Nzz', {silent = true})
  vim.keymap.set('n', '<C-o>', '<C-o>zz', {silent = true})
  vim.keymap.set('n', '<C-i>', '<C-i>zz', {silent = true})

  vim.keymap.set('n', 'L', ':bnext<CR>', {silent = true})
  vim.keymap.set('n', 'H', ':bprevious<CR>', {silent = true})

  --remaps for react extract
  vim.keymap.set({ "n" }, "<Leader>rp", ":lua require('custom').extract_to_new_file()<CR>",{silent = true,expr=false})
  vim.keymap.set({ "n" }, "<Leader>rc", ":lua require('custom').extract_to_current_file()<CR>",{silent = true, expr = false})
  -- Remaps for the refactoring operations currently offered by the plugin

  vim.keymap.set("v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
  )
