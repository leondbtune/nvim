return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "ruff.toml",
    ".ruff.toml",
    ".git",
  },
  init_options = {
    settings = {
      lineLength = 119,
      organizeImports = false,
      lint = {
        enable = true,
        select = { "E", "F", "W", "U", "C4", "LOG0", "ANN" },
        ignore = { "E203", "E501", "E731", "E741", "UP032", "UP046", "ANN401" },
      },
    },
  },
}
