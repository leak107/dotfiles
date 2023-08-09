require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    autotag = {
        enable = true
    },
    indent = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['if'] = '@function.inner',
                ['af'] = '@function.outer',
                ['ia'] = '@parameter.inner',
                ['aa'] = '@parameter.outer',
            }
        }
    }
}
