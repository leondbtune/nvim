local options = {
	clipboard = "unnamedplus",
	number = true,
	relativenumber = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	autoread = true,
}


for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Make window separators more visible
vim.opt.laststatus = 3
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#838ba7", bold = true })

vim.diagnostic.config({
	signs = false,
	virtual_text = true,
})

-- Auto-reload files changed externally (e.g. by Claude Code)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	command = "checktime",
})

-- Enable treesitter highlighting for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua", "vim", "bash", "html", "css", "javascript" },
	callback = function()
		vim.treesitter.start()
	end,
})


