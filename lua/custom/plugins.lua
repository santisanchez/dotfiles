-- pcall(require, 'custom.setup_plugins')
-- pcall(require, 'custom.mappings')
local plugins = function(use)
    use { "nathom/filetype.nvim" }
    use {
        'hoschi/yode-nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('yode-nvim').setup({})
        end

    }

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

    use({ "adalessa/laravel.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "rcarriga/nvim-notify" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("laravel").setup({
                split_cmd = "vertical",
                split_width = 120,
                bind_telescope = true,
                ask_for_args = true,
            })
        end
    })

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
    -- use {
    --     'nvim-tree/nvim-tree.lua',
    --     requires = {
    --         'nvim-tree/nvim-web-devicons', -- optional, for file icons
    --     },
    --     tag = 'nightly', -- optional, updated every week. (see issue #1193)
    --     config = function ()
    --         require("nvim-tree").setup()
    --     end
    -- }

    use { "jose-elias-alvarez/null-ls.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" }
        }
    }
end


return plugins
