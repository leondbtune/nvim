require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "ruff" },
})
vim.lsp.enable({
    "pyright",
    "ruff",
})
