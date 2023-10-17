local neotest = require('neotest')

neotest.setup({
    adapters = {
        require('neotest-go'),
        require('neotest-pest'),
        require('neotest-phpunit'),
    }
})
