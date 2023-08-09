vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{
            'nvim-lua/plenary.nvim',
        }}
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'mbbill/undotree'
    use 'lewis6991/gitsigns.nvim'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'machakann/vim-sandwich'
    use 'tpope/vim-eunuch'
    -- use 'tpope/vim-sleuth'
    -- use 'sheerun/vim-polyglot'
    use 'nvim-tree/nvim-tree.lua'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'akinsho/bufferline.nvim'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use ({
        'AndrewRadev/splitjoin.vim',
        config = function ()
            vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_php_method_cahin_full = 1
        end,
    })
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
                'williamboman/mason.nvim',
                -- 'jose-elias-alvarez/null-ls.nvim',
                -- 'mason-null-ls.nvim',
                run = function()
                    vim.cmd("MasonUpdate")
                end,
            },
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        }
    }

    -- Theme
    use "rebelot/kanagawa.nvim"
    use { "catppuccin/nvim", as = "catppuccin" }
    use "folke/tokyonight.nvim"
end)
