local null_ls = require("null-ls")
local laravel_actions = require("laravel.code-actions")
null_ls.setup({
    sources = {
        laravel_actions.relationships,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.gitsigns,
    },
})
