local options = {
	clipboard = "unnamedplus",
}


for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.diagnostic.config({
	signs = false,
})
