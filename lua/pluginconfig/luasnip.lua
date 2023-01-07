require('luasnip').filetype_extend("javascript", { "javascriptreact" })

require("luasnip.loaders.from_vscode").lazy_load({ paths = {
    "~/.local/share/nvim/site/pack/packer/start/friendly-snippets"
} })
