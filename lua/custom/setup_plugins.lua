return function()
    --Enable refactoring
    require('refactoring').setup({})

    --Enable react-extract
    require("react-extract").setup()

    -- focused code edit
    require('yode-nvim').setup({})

end
