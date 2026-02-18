return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local dap_python = require("dap-python")

			-- Setup dap-ui
			dapui.setup()

			-- Setup dap-python with debugpy installed via Mason
			-- Mason installs debugpy at this location
			local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			dap_python.setup(mason_path)

			-- Automatically open/close dap-ui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Python debugging configurations
			dap.configurations.python = dap.configurations.python or {}
			table.insert(dap.configurations.python, {
				type = "python",
				request = "attach",
				name = "Attach to port 5678",
				connect = {
					host = "127.0.0.1",
					port = 5678,
				},
				pathMappings = {
					{
						localRoot = vim.fn.getcwd(),
						remoteRoot = ".",
					},
				},
				justMyCode = false,
			})
		end,
	},
}
