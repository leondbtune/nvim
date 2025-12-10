return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "python", "lua", "vim", "vimdoc", "bash" },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}
