-- lua/plugins/lsp.lua
return {
{
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
},
{
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
	ensure_installed = {
		-- LSP servers
		"pyright",
		"ruff",
		"lua_ls",

		-- Formatters
		"black",

		-- Linters
		"mypy",

		-- Debug adapters
		"debugpy"
	}
    },
}
  }
