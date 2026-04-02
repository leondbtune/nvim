require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "ruff" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "pyright",
    "ruff",
})
