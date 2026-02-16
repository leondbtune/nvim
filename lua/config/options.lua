local options = {
	clipboard = "unnamedplus",
	number = true,
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true
}


for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.diagnostic.config({
	signs = false,
	virtual_text = true,
})

-- Enable treesitter highlighting for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python", "lua", "vim", "bash", "html", "css", "javascript" },
	callback = function()
		vim.treesitter.start()
	end,
})


