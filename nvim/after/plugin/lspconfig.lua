local lsp = require('lsp-zero').preset('recommended')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<CR>"] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
})

lsp.ensure_installed({
    'gopls',
    'tsserver',
    'eslint',
    'dockerls',
    'docker_compose_language_service',
    'volar',
    'phpactor',
    'pest_ls',
    'tailwindcss',
    'html',
    'cssls',
    'rust_analyzer',
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I',
    }
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})

    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', {buffer = true})
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', {buffer = true})
    vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = true})
    vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', {buffer = true})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').volar.setup{
    filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue'}
}

lsp.setup()

vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = true
    }
})
