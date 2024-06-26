vim.g.neoformat_try_node_exe = 1

vim.api.nvim_create_autocmd('BufWritePre', {
	desc = 'Format json after save',
	pattern = '*.json',
	callback = function (opts)
		if vim.bo[opts.buf].filetype == 'json' then
			vim.cmd 'Neoformat'
		end
	end
})
