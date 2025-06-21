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

	vim.keymap.set({ "n", "i" }, "gI", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, opts)
end

lsp.extend_lspconfig({
	sign_text = true,
	lsp_attach = lsp_attach,
	float_border = 'rounded',
	capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.set_log_level("debug")

require('mason').setup({})
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup {
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

lspconfig.gopls.setup({})
lspconfig.pyright.setup{}

lspconfig.intelephense.setup({
	cmd = {"intelephense", "--stdio"},
	filetypes = {"php"},
})

lspconfig.phpactor.setup({
	cmd = {"phpactor", "language-server"},
	filetypes = {'php'},
})

lspconfig.tailwindcss.setup({
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
--
-- VolarCapabilities = vim.lsp.protocol.make_client_capabilities()
-- VolarCapabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
--
-- lspconfig.volar.setup({
-- 	capabilities = VolarCapabilities,
-- 	-- NOTE: Uncomment to enable volar in file types other than vue.
-- 	-- (Similar to Takeover Mode)
--
-- 	filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact", "json" },
--
-- 	init_options = {
-- 		vue = {
-- 			hybridMode = false,
-- 		},
-- 		-- NOTE: This might not be needed. Uncomment if you encounter issues.
--
-- 		-- typescript = {
-- 		-- 	tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
-- 		-- },
-- 	},
-- 	settings = {
-- 		typescript = {
-- 			inlayHints = {
-- 				enumMemberValues = {
-- 					enabled = true,
-- 				},
-- 				functionLikeReturnTypes = {
-- 					enabled = true,
-- 				},
-- 				propertyDeclarationTypes = {
-- 					enabled = true,
-- 				},
-- 				parameterTypes = {
-- 					enabled = true,
-- 					suppressWhenArgumentMatchesName = true,
-- 				},
-- 				variableTypes = {
-- 					enabled = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- })
--
local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"
local volar_path = mason_packages .. "/vue-language-server/node_modules/@vue/language-server"

lspconfig.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = volar_path,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}


-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup {}
-- lspconfig.tsserver.setup({
-- 	init_options = {
-- 		plugins = {
-- 			{
-- 				name = '@vue/typescript-plugin',
-- 				location = volar_path,
-- 				languages = {"javascript", "typescript", "vue"},
-- 			},
-- 		},
-- 	},
-- 	-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
-- 	settings = {
-- 		typescript = {
-- 			inlayHints = {
-- 				includeInlayParameterNameHints = "all",
-- 				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
-- 				includeInlayFunctionParameterTypeHints = true,
-- 				includeInlayVariableTypeHints = true,
-- 				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
-- 				includeInlayPropertyDeclarationTypeHints = true,
-- 				includeInlayFunctionLikeReturnTypeHints = true,
-- 				includeInlayEnumMemberValueHints = true,
-- 			},
-- 		},
-- 	}
-- })



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

local current_dir = vim.fn.getcwd()

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
