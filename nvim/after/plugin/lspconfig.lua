local lsp = require('lsp-zero').preset('minimal')

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})

    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', {buffer = true})
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', {buffer = true})
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = true})
    vim.keymap.set('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {buffer = true})
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', {buffer = true})
end)


local cmp = require('cmp')

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}),
        ['<C-k>'] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path'},
        { name = 'buffer'},
    })
 })

local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local current_dir = vim.fn.getcwd()

nvim_lsp['phpactor'].setup({cmd = {"phpactor", "language-server"}, capabilities = capabilities, filetypes = {'php'}})
nvim_lsp['lua_ls'].setup(lsp.nvim_lua_ls())
nvim_lsp['html'].setup({capabilities = capabilities})
nvim_lsp['tailwindcss'].setup({capabilities = capabilities, filetypes = {'typescript', 'html', 'vue'}})
nvim_lsp['intelephense'].setup({capabilities = capabilities, filetypes = {'php'}, settings = {
	intelephense = {
		environment = {
			includePaths = { current_dir }
		}
	}
}})

nvim_lsp['tsserver'].setup({capabilities = capabilities, filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }})
nvim_lsp['volar'].setup({
	capabilities = capabilities,
	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = true
    }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
