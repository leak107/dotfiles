local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})
vim.keymap.set('n', '<C-b>', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

--Telescope Mapping
local actions = require "telescope.actions"

require("telescope").setup{
	defaults = {
		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-c>"] = actions.close,
				["<C-u>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			}
		},
		pickers = {
			find_files = {
				hidden = false
			}
		}
	}
}
