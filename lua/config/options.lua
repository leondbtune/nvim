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
})
