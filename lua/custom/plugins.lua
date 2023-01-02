local plugins = function(use)
    use { 'folke/tokyonight.nvim' }
    use { "nathom/filetype.nvim" }
    use {
        'hoschi/yode-nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('yode-nvim').setup({})
        end

    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use { "windwp/nvim-ts-autotag" }

    use { "rafamadriz/friendly-snippets" }

    use { 'nvim-treesitter/playground' }

    use {
        "ThePrimeagen/refactoring.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        },
        config = function()
            require('refactoring').setup({})
        end
    }

    use { "adalessa/laravel.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "rcarriga/nvim-notify" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("laravel").setup({
                split_cmd = "horizontal",
                split_height = 10,
                bind_telescope = true,
                ask_for_args = true,
            })
        end
    }

    use { "napmn/react-extract.nvim", config = function()
        require("react-extract").setup()
    end }


    use { 'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("bufferline").setup()
        end
    }



    use { "nvim-telescope/telescope-file-browser.nvim" }

    use { "jose-elias-alvarez/null-ls.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }

    use { "ggandor/leap.nvim" }

    use {
        "ThePrimeagen/harpoon",
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()

        end
    }

    use {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require "telescope".load_extension("frecency")
        end,
        requires = { "kkharji/sqlite.lua" }
    }
end


return plugins
