local plugins =function(use)
    use {
        'hoschi/yode-nvim',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'folke/tokyonight.nvim'
    }

    

    use { 'nvim-treesitter/playground' }

    use {
      "ThePrimeagen/refactoring.nvim",
      requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
      }
    }

    use {"napmn/react-extract.nvim"}
end

return plugins
