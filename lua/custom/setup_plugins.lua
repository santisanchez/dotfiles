local M = {}

M.setup = function()
  --Enable refactoring
  require('refactoring').setup({})

  --Enable react-extract
  require("react-extract").setup()

  require('yode-nvim').setup({})
end

return M