return {
    {"mason-org/mason.nvim"},
    {"mason-org/mason-lspconfig.nvim"},
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          python = { "isort", "black" },
          javascript = { "eslint_d" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      },
    }
}
