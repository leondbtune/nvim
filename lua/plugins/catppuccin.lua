return {
  -- Colorscheme for better visuals
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load early
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- Options: latte, frappe, macchiato, mocha
        transparent_background = true,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          telescope = true,
          nvimtree = true,
          mason = true,
          alpha = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
