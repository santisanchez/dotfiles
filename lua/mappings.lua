-- My Mappings
vim.g.neovide_input_macos_alt_is_meta = true

-- [_Lsp]
vim.keymap.set('n', '<C-s>', ':wa<CR>', { silent = true })

-- vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
--cycle through windows
vim.keymap.set("n","<Tab>","<C-w>w",{silent=true,noremap=true})
-- move lines around
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- manual indent
vim.keymap.set('x', '<', '<gv', {silent=true,noremap=true})
vim.keymap.set('x', '>', '>gv', {silent=true,noremap=true})

-- Join the next line and keep the cursor position
-- vim.keymap.set("n", "J", "mzJ`z")

--better clipboard
-- vim.keymap.set("x", "<leader>p", [["_dP]])
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Replace this shitty word
-- vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })
vim.keymap.set('t', '<leader>c', ':bd!<CR>', {silent=true, noremap=true})

vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true })
vim.keymap.set('n', '[q', ':cprevious<CR>', { silent = true })
vim.keymap.set('n', ']b', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '[b', ':bprevious<CR>', { silent = true })

-- Center to the cursor on screen movement
vim.keymap.set('n', '<C-f>', '<C-f>zz', { silent = true })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
-- vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
-- vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { silent = true })

--remaps for react extract
vim.keymap.set({ "n" }, "<leader>rp", ":lua require('custom').extract_to_new_file()<CR>", { silent = true, expr = false })
vim.keymap.set({ "n" }, "<leader>rc", ":lua require('custom').extract_to_current_file()<CR>",
    { silent = true, expr = false })
-- Remaps for the refactoring operations currently offered by the plugin

vim.keymap.set("x",
    "<leader>bs",
    ":'<,'>YodeCreateSeditorFloating<CR>",
    { noremap = true }
)

vim.keymap.set("x",
    "<leader>br",
    ":'<,'>YodeCreateSeditorReplace<CR>",
    { noremap = true }
)

vim.keymap.set("n",
    "<leader>bd",
    "<cmd>YodeBufferDelete<CR>",
    { noremap = true }
)

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
--
vim.keymap.set('i', ';', '<Esc>A;', { silent = true, noremap = true })
