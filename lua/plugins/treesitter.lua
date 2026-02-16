return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      -- Install parsers via command - run :TSInstall python lua vim vimdoc bash
      -- Or use :TSInstall all for common parsers
    end,
  },
}
