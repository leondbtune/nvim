return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Custom ty linter: runs `ty check --output-format concise` on file
    -- Output format: file:line:col: severity[code] message
    local pattern = "([^:]+):(%d+):(%d+): (%a+)%[([%a-]+)%] (.*)"
    local groups = { "file", "lnum", "col", "severity", "code", "message" }
    local severities = {
      error = vim.diagnostic.severity.ERROR,
      warning = vim.diagnostic.severity.WARN,
      info = vim.diagnostic.severity.INFO,
    }

    lint.linters.ty = function()
      local args = {
        "check",
        "--output-format", "concise",
      }

      local venv = vim.fn.getenv("VIRTUAL_ENV")
      if venv and venv ~= vim.NIL then
        table.insert(args, "--python")
        table.insert(args, venv .. "/bin/python")
      end

      return {
        cmd = "ty",
        stdin = false,
        append_fname = true,
        stream = "stdout",
        ignore_exitcode = true,
        args = args,
        parser = require("lint.parser").from_pattern(
          pattern,
          groups,
          severities,
          { ["source"] = "ty" }
        ),
      }
    end

    lint.linters_by_ft = {
      python = { "ty" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
