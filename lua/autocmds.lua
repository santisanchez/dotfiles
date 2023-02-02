local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

local remove_spaces = vim.api.nvim_create_augroup("RemoveSpaces",{clear=true})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = remove_spaces,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
-- autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

local close_quicklist = vim.api.nvim_create_augroup("CloseQuickList", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = close_quicklist,
    pattern = { "qf" },
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
})
-- autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

-- local db_group = vim.api.nvim_create_augroup('DbCompletion', { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--     group = db_group,
--     pattern = "mysql",
--     command = [[lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })]],
-- })
