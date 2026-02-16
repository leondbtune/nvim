return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        diagnosticSeverityOverrides = {
          reportPrivateImportUsage = "none",
        },
      },
    },
  },
  before_init = function(_, config)
    -- Use venv python if VIRTUAL_ENV is set (by venv-selector or shell)
    local venv_path = vim.fn.getenv("VIRTUAL_ENV")
    if venv_path and venv_path ~= vim.NIL then
      config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
        python = { pythonPath = venv_path .. "/bin/python" }
      })
    end
  end,
}
