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

			dapui.setup()

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

			-- Helper: load env file into a table
			local function load_env_file(path)
				local env = {}
				local f = io.open(path, "r")
				if not f then return env end
				for line in f:lines() do
					if line:match("^[^#]") then
						local key, val = line:match("^([%w_]+)%s*=%s*(.*)$")
						if key then env[key] = val end
					end
				end
				f:close()
				return env
			end

			local tms = "/Users/leon.bethuyne/Dev/Source/backend/projects/tms"
			local manage = tms .. "/src/manage.py"
			local dev_env = tms .. "/deploy/environment/dev-venv.env"
			local test_env = tms .. "/deploy/environment/test.env"
			local prod_env = tms .. "/deploy/environment/prod.env"

			-- Helper: create a manage.py launch config
			local function dj(name, args, env_file, extra_env, opts)
				opts = opts or {}
				return {
					type = "python",
					request = "launch",
					name = name,
					program = manage,
					args = args,
					django = true,
					justMyCode = opts.justMyCode ~= false,
					env = function()
						local env = load_env_file(env_file or dev_env)
						if extra_env then
							for k, v in pairs(extra_env) do env[k] = v end
						end
						return env
					end,
				}
			end

			-- Helper: create an attach config
			local function attach(name, port, opts)
				opts = opts or {}
				return {
					type = "python",
					request = "attach",
					name = name,
					connect = { host = "127.0.0.1", port = port },
					justMyCode = opts.justMyCode ~= false,
					pathMappings = opts.pathMappings,
				}
			end

			dap.configurations.python = {
				-- ═══════════════════════════════════
				-- Local Dev (launch)
				-- ═══════════════════════════════════
				dj("Django LocalDB", { "runserver", "0.0.0.0:8081" }),
				dj("Django LocalDB (no async)", { "runserver", "0.0.0.0:8081" }, nil, {
					SKIP_ASYNC_PIPELINE_EXECUTION = "true",
				}),

				-- ═══════════════════════════════════
				-- PubSub (launch)
				-- ═══════════════════════════════════
				dj("PubSub Pull LocalDB", { "pubsub_pull" }),
				dj("PubSub Pull Nylas (emulator)", { "pubsub_pull" }, nil, {
					PUBSUB_INCOMING_MESSAGE_FORMAT = "NYLAS",
					PUBSUB_SUBSCRIPTIONS = "nylas",
				}),
				dj("PubSub Pull Nylas (nylas-dev)", { "pubsub_pull" }, nil, {
					PUBSUB_EMULATOR_HOST = "",
					PUBSUB_PROJECT = "qargo-nylas-test",
					PUBSUB_INCOMING_MESSAGE_FORMAT = "NYLAS",
					PUBSUB_SUBSCRIPTIONS = "nylas-dev-notifications-subscription",
				}),
				dj("PubSub Pull email metadata (email-metadata-dev)", { "pubsub_pull" }, nil, {
					PUBSUB_EMULATOR_HOST = "",
					PUBSUB_PROJECT = "qargo-test",
					PUBSUB_SUBSCRIPTIONS = "email-metadata-dev-sub",
				}),

				-- ═══════════════════════════════════
				-- Migrations
				-- ═══════════════════════════════════
				dj("Migrate LocalDB", { "migrate" }),
				dj("MakeMigrations", { "makemigrations", "main" }),
				dj("Make Empty Migration", { "makemigrations", "main", "--name", "changethis", "--empty" }),
				dj("MergeMigrations", { "makemigrations", "--merge", "main" }),
				dj("ListMigrations", { "showmigrations", "--list" }),

				-- ═══════════════════════════════════
				-- Other environments
				-- ═══════════════════════════════════
				dj("Django TestDB", { "runserver", "0.0.0.0:8081" }, test_env),
				dj("Django ProdDB", { "runserver", "0.0.0.0:8081" }, prod_env),
				dj("Django Shell", { "shell" }),
				dj("Firebase auth check (prod)", { "firebase_auth_check" }, prod_env),

				-- ═══════════════════════════════════
				-- Sync
				-- ═══════════════════════════════════
				dj("Schedule sync", { "schedule_sync" }),
				dj("Schedule sync once", { "schedule_sync", "--debug" }),
				dj("Sync sign on device", { "sync_sign_on_device" }),
				dj("Simulate visibility update", {
					"simulate_visibility_update",
					"TENANT_ID", "INTEGRATION_PARTNER", "EVENT_TYPE", "ROW_ID",
					"--integration-instance-id", "INTEGRATION_INSTANCE_ID",
				}),

				-- ═══════════════════════════════════
				-- Template schemas
				-- ═══════════════════════════════════
				dj("Compile document template schemas", { "compile_document_template_schemas" }),
				dj("Create template schema to translate", { "transform_template_schema_to_schema_to_translate" }),

				-- ═══════════════════════════════════
				-- Testing
				-- ═══════════════════════════════════
				{
					type = "python",
					request = "launch",
					name = "Test current file (local DB)",
					module = "pytest",
					args = { "-c", "setup.cfg", "-v", "${file}" },
					justMyCode = true,
					env = function()
						local env = load_env_file(dev_env)
						env.PYTHONPATH = "./src"
						return env
					end,
				},
				{
					type = "python",
					request = "launch",
					name = "Test current file (test DB)",
					module = "pytest",
					args = { "-c", "setup.cfg", "-v", "${file}" },
					justMyCode = true,
					env = function()
						local env = load_env_file(dev_env)
						env.PYTHONPATH = "./src"
						env.RUN_AGAINST_TEST_DATABASE = "true"
						return env
					end,
				},

				-- ═══════════════════════════════════
				-- Generic
				-- ═══════════════════════════════════
				{
					type = "python",
					request = "launch",
					name = "Run current file",
					program = "${file}",
					justMyCode = false,
				},
				{
					type = "python",
					request = "launch",
					name = "Start FTP server",
					program = tms .. "/scripts/ftp_server.py",
					justMyCode = true,
				},

				-- ═══════════════════════════════════
				-- Attach (for terminal debug sessions)
				-- ═══════════════════════════════════
				attach("Attach to port 5678 (server)", 5678, { justMyCode = false }),
				attach("Attach to port 5679 (pubsub)", 5679, { justMyCode = false }),
				attach("Attach to port 5679 (remote)", 5679, {
					justMyCode = true,
					pathMappings = {
						{ localRoot = tms, remoteRoot = "/src/projects/tms" },
					},
				}),
			}

			-- ═══════════════════════════════════
			-- Compound commands (attach to multiple debug terminals)
			-- ═══════════════════════════════════

			-- Attach to server (5678) + pubsub (5679)
			vim.api.nvim_create_user_command("DapAttachLocalDev", function()
				dap.run(attach("server (5678)", 5678, { justMyCode = false }))
				vim.defer_fn(function()
					dap.run(attach("pubsub (5679)", 5679, { justMyCode = false }))
				end, 1000)
			end, { desc = "Attach to server + pubsub debug sessions" })

			-- Switch between active debug sessions
			vim.api.nvim_create_user_command("DapSwitchSession", function()
				local sessions = dap.sessions()
				if #sessions < 2 then
					vim.notify("Only one active session", vim.log.levels.INFO)
					return
				end
				local items = {}
				for _, s in ipairs(sessions) do
					table.insert(items, s)
				end
				vim.ui.select(items, {
					prompt = "Select debug session:",
					format_item = function(s) return s.config.name end,
				}, function(selected)
					if selected then dap.set_session(selected) end
				end)
			end, { desc = "Switch between active DAP sessions" })

			-- Terminate all active sessions
			vim.api.nvim_create_user_command("DapTerminateAll", function()
				for _, s in ipairs(dap.sessions()) do
					dap.set_session(s)
					dap.terminate()
				end
			end, { desc = "Terminate all debug sessions" })

			-- Keymaps for compound commands
			vim.keymap.set("n", "<leader>dL", "<cmd>DapAttachLocalDev<cr>", { desc = "Attach Local Dev (server + pubsub)" })
			vim.keymap.set("n", "<leader>ds", "<cmd>DapSwitchSession<cr>", { desc = "Switch DAP session" })
			vim.keymap.set("n", "<leader>dQ", "<cmd>DapTerminateAll<cr>", { desc = "Terminate all DAP sessions" })
		end,
	},
}
