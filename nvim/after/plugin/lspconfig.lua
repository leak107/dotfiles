local lsp = require('lsp-zero')

local lsp_attach = function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})

    -- vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', {buffer = true})
    -- vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', {buffer = true})
    -- vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = true})
    -- vim.keymap.set('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {buffer = true})

	local opts = {buffer = bufnr}

    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', {buffer = true})
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
	vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
	vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
	vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
	vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
	vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	float_border = 'rounded',
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here 
	-- with the ones you want to install
	-- ensure_installed = {'lua_ls', 'rust_analyzer', 'phpactor', 'intelephense', 'volar', 'gopls'},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
	lua_ls = function ()
		require('lspconfig').lua_ls.setup {
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
					return
				end

				client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
					runtime = {
						version = 'LuaJIT'
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME
						}
					}
				})
			end,
			settings = {
				Lua = {}
			}
		}
	end,
	intelephense = function ()
		require('lspconfig').phpactor.setup({
			cmd = {"intelephense", "--stdio"},
			filetypes = {"php"},
			root_dir = root_pattern("composer.json", ".git"),
		})
	end,
	phpactor = function ()
		require('lspconfig').phpactor.setup({
			cmd = {"phpactor", "language-server"},
			filetypes = {'php'},
			root_dir = root_pattern("composer.json", ".git"),
		})
	end,
	tailwindcss = function ()
		require('lspconfig').tailwindcss.setup({
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = {"typescript", "html", "vue", "js"},
		})
	end,
	volar = function ()
		require('lspconfig').volar.setup({
			filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
			root_dir = root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.mjs', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.cjs', 'postcss.config.mjs', 'postcss.config.ts', 'package.json', 'node_modules', '.git'),
			init_options = {
				vue = {
					hybridMode = false,
				},
			},
		})
	end
})

local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path'},
		{ name = 'buffer'},
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
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
})

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

local current_dir = vim.fn.getcwd()

-- nvim_lsp['phpactor'].setup({})
-- nvim_lsp['lua_ls'].setup(lsp.nvim_lua_ls())
-- nvim_lsp['html'].setup({capabilities = capabilities})
-- nvim_lsp['tailwindcss'].setup({capabilities = capabilities, filetypes = {'typescript', 'html', 'vue'}})
-- nvim_lsp['intelephense'].setup({capabilities = capabilities, filetypes = {'php'}, settings = {
-- 	intelephense = {
-- 		environment = {
-- 			includePaths = { current_dir }
-- 		}
-- 	}
-- }})

-- nvim_lsp['tsserver'].setup({
-- 	init_options = {
-- 		plugins = {
-- 			{
-- 				name = '@vue/typescript-plugin',
-- 				location = '/home/aston/.local/share/nvim/mason/bin/vue-language-server',
-- 				languages = { 'vue' },
-- 			},
-- 		},
-- 	},
-- 	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
-- })
--
-- nvim_lsp['volar'].setup({
-- 	capabilities = capabilities,
-- 	filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
-- 	init_options = {
-- 		vue = {
-- 			hybridMode = false,
-- 		},
-- 	},
-- })

-- lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    float = {
        source = true
    }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
