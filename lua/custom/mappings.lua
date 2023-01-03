-- My Mappings
vim.keymap.set('n', '<C-s>', ':wa<CR>', { silent = true })

-- vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })
vim.keymap.set(
    "n",
    "<leader>t",
    ":Telescope file_browser path=%:p:h<CR>",
    { noremap = true, silent = true }
)

-- move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join the next line and keep the cursor position
vim.keymap.set("n", "J", "mzJ`z")

--better clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Replace this shitty word
-- vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
--harpoon
vim.keymap.set('n', '<leader>a', harpoon_mark.add_file, { silent = true })
vim.keymap.set('n', '<C-e>', harpoon_ui.toggle_quick_menu, { silent = true })
vim.keymap.set('n', '-', harpoon_ui.nav_next, { silent = true })
vim.keymap.set('n', '=', harpoon_ui.nav_prev, { silent = true })
vim.keymap.set('n', '<F1>', ":lua require('harpoon.ui').nav_file(1)<CR>", { silent = true })
vim.keymap.set('n', '<F2>', ":lua require('harpoon.ui').nav_file(2)<CR>", { silent = true })
vim.keymap.set('n', '<F3>', ":lua require('harpoon.ui').nav_file(3)<CR>", { silent = true })
vim.keymap.set('n', '<F4>', ":lua require('harpoon.ui').nav_file(4)<CR>", { silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

vim.keymap.set('n', '<C-j>', ':cnext<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':cprevious<CR>', { silent = true })

-- Center to the cursor on screen movement
vim.keymap.set('n', '<C-f>', '<C-f>zz', { silent = true })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { silent = true })
vim.keymap.set('n', '<C-o>', '<C-o>zz', { silent = true })
vim.keymap.set('n', '<C-i>', '<C-i>zz', { silent = true })

vim.keymap.set('n', 'L', ':bnext<CR>', { silent = true })
vim.keymap.set('n', 'H', ':bprevious<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { silent = true })

--remaps for react extract
vim.keymap.set({ "n" }, "<leader>rp", ":lua require('custom').extract_to_new_file()<CR>", { silent = true, expr = false })
vim.keymap.set({ "n" }, "<leader>rc", ":lua require('custom').extract_to_current_file()<CR>",
    { silent = true, expr = false })
-- Remaps for the refactoring operations currently offered by the plugin

vim.keymap.set("v",
    "<leader>rr",
    "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
    { noremap = true }
)

vim.keymap.set("v",
    "<leader>yc",
    "<cmd>'<,'>YodeCreateSeditorFloating<CR>",
    { noremap = true }
)


vim.keymap.set("v",
    "<leader>yr",
    "<cmd>'<,'>YodeCreateSeditorReplace<CR>",
    { noremap = true }
)

vim.keymap.set("n",
    "<leader>yd",
    "<cmd>YodeBufferDelete<CR>",
    { noremap = true }
)
