local neotest = require('neotest')

neotest.setup({
    adapters = {
        require('neotest-go'),
        require('neotest-pest'),
        require('neotest-phpunit'),
    }
})

vim.keymap.set('n', '<leader>tn', function() neotest.run.run() end)
