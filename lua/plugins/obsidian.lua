-- Notes vault at ~/Dev/Docs (see Docs/index.md for conventions).
-- Using the community-maintained fork `obsidian-nvim/obsidian.nvim`
-- (epwalsh/obsidian.nvim was archived in 2025).
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  -- also load when opening any file under the vault
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Dev/Docs/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Dev/Docs/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  ---@module "obsidian"
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      { name = "docs", path = "~/Dev/Docs" },
    },

    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",

    daily_notes = {
      folder = "meetings",
      date_format = "%Y-%m/daily-%Y-%m-%d",
      default_tags = { "daily" },
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Use plain markdown links so `gf` and non-Obsidian tools keep working.
    link = { style = "markdown" },

    legacy_commands = false,

    picker = { name = "telescope.nvim" },

    ui = { enable = false }, -- you already have render-markdown.nvim
  },
  -- Telescope already covers file finding (<leader>ff) and grep, so we only
  -- map the things Obsidian uniquely provides.
  keys = {
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>",       desc = "Obsidian: backlinks" },
    { "<leader>oT", "<cmd>Obsidian tags<cr>",            desc = "Obsidian: tags" },
    { "<leader>ot", "<cmd>Obsidian today<cr>",           desc = "Obsidian: today's note" },
    { "<leader>on", "<cmd>Obsidian new<cr>",             desc = "Obsidian: new note" },
    { "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Obsidian: toggle checkbox" },
  },
}
