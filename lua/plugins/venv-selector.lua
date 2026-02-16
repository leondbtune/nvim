return { {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select venv" },
  },
  opts = {
    settings = {
      hooks = {
        on_venv_activate = function()
          -- Restart pyright to pick up the new venv
          vim.cmd("LspRestart pyright")
        end,
      },
    },
  },
},}
