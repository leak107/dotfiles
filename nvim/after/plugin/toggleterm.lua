
require("toggleterm").setup{
	size = 20,
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	shade_terminals = true,
	autochdir = true,
	shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = 'horizontal',
	float_opts = {
		border = 'single', -- double, single, shadow, none
		width = 200,
		height = 50,
		winblend = 3,
		highlights = {
			border = "Normal",
			background = "Normal",
		}
	},
	winbar = {
		enabled = true,
		name_formatter = function(term) --  term: Terminal
			return term.name
		end
	},

}
