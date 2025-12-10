return {
  -- Colorscheme for better visuals
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load early
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  }
