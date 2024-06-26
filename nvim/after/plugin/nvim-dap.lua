local dap = require('dap')

dap.adapters.php = {
	type = 'executable',
	command = 'node',
	args = { '~/tools/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
	{
		type = 'php',
		request = 'launch',
		name = 'Listen for Xdebug',
		port = 9000
	}
}

local dapui = require("dapui").setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set('n', '<leader>dt', function() require('dapui').toggle() end)
