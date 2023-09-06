return {
	"nvim-tree/nvim-web-devicons",
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		}
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate'
	},
	'nvim-treesitter/nvim-treesitter-textobjects',
	'mbbill/undotree',
	'lewis6991/gitsigns.nvim',
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'theutz/neotest-pest',
            'olimorris/neotest-phpunit',
        }
    },
    {
        'windwp/nvim-ts-autotag',
        config = function ()
            require('nvim-ts-autotag').setup()
        end,
    },
	{
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	},
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        'AndrewRadev/splitjoin.vim',
        config = function ()
            vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
            vim.g.splitjoin_trailing_comma = 1
            vim.g.splitjoin_php_method_cahin_full = 1
        end,
    },
    'machakann/vim-sandwich',
	'tpope/vim-eunuch',
	'nvim-tree/nvim-tree.lua',
	'lukas-reineke/indent-blankline.nvim',
	'nvim-lualine/lualine.nvim',
	'akinsho/bufferline.nvim',
	"rebelot/kanagawa.nvim",
	{ "catppuccin/nvim", name = "catppuccin" },
	{                                      -- Optional
		'williamboman/mason.nvim',
		build = function()
			vim.cmd("MasonUpdate")
		end,
	},
	"folke/tokyonight.nvim",
    "metalelf0/jellybeans-nvim",
    "rebelot/kanagawa.nvim",
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
					{'williamboman/mason-lspconfig.nvim'}, -- Optional
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},     -- Required
			{'hrsh7th/cmp-nvim-lsp'}, -- Required
			{'L3MON4D3/LuaSnip'},     -- Required
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-cmdline'},
			{'saadparwaiz1/cmp_luasnip'},
		}
	}
}
