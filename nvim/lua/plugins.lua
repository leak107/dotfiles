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
    'ellisonleao/gruvbox.nvim',
    'projekt0n/github-nvim-theme',
	-- "sheerun/vim-polyglot",
	{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'Shatur/neovim-ayu' },
    {
        'nvim-neotest/neotest',
        dependencies = {
			"nvim-neotest/nvim-nio",
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim',
            'olimorris/neotest-phpunit',
			"V13Axel/neotest-pest",
            'nvim-neotest/neotest-go',
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
        "NvChad/nvim-colorizer.lua",
        config = function ()
            require("colorizer").setup{
                filetypes = { "*" },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = false, -- "Name" codes like Blue or blue
                    RRGGBBAA = false, -- #RRGGBBAA hex codes
                    AARRGGBB = false, -- 0xAARRGGBB hex codes
                    rgb_fn = false, -- CSS rgb() and rgba() functions
                    hsl_fn = false, -- CSS hsl() and hsla() functions
                    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
                    virtualtext = "■",
                    -- update color values even if buffer is not focused
                    -- example use: cmp_menu, cmp_docs
                    always_update = false
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            }
        end
    },
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    },
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
	},
	{
		{'akinsho/toggleterm.nvim', version = "*", config = true}
	},
}
